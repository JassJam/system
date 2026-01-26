{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-ssh = config.secrets.ssh;
in
{
  options.secrets.ssh = {
    enable = lib.mkEnableOption "SSH client for secure shell access";
    enable-music-server = lib.mkEnableOption "Music server SSH configuration with sops secrets";
  };

  config = lib.mkIf cfg-ssh.enable {
    home-manager.users.${userName} =
      { config, ... }:
      {
        sops.templates."ssh-music-server-config" = lib.mkIf cfg-ssh.enable-music-server {
          content = ''
            Host music-server
              HostName ${config.sops.placeholder."ssh/music_server/hostname"}
              User ${config.sops.placeholder."ssh/music_server/user"}
              IdentityFile ~/.ssh/music-server
              IdentitiesOnly yes
          '';
        };

        programs.ssh = {
          enable = true;
          enableDefaultConfig = false;

          matchBlocks = {
            "*" = {
              serverAliveInterval = 60;
              serverAliveCountMax = 3;
            };

            "github.com" = {
              user = "git";
              identityFile = "~/.ssh/github-${userName}";
              identitiesOnly = true;
            };

            "codeberg.org" = {
              user = "git";
              identityFile = "~/.ssh/codeberg-${userName}";
              identitiesOnly = true;
            };
          };

          extraConfig = ''
            AddKeysToAgent yes
          ''
          + lib.optionalString cfg-ssh.enable-music-server ''
            Include ${config.sops.templates."ssh-music-server-config".path}
          '';
        };
      };
  };
}
