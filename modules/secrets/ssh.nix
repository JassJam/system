{
  jutils,
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
  options.secrets.ssh = jutils.mkOptions {
    description = "SSH client for secure shell access.";
  };

  config = lib.mkIf cfg-ssh.enable {
    home-manager.users.${userName} =
      { config, ... }:
      {
        programs.ssh = {
          enable = true;
          enableDefaultConfig = false;

          matchBlocks = {
            "*" = {
              serverAliveInterval = 60;
              serverAliveCountMax = 3;
              identitiesOnly = true;
            };
          };
        }
        // cfg-ssh.options;
      };
  };
}
