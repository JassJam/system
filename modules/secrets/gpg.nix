{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-gpg = config.secrets.gpg;
in
{
  options.secrets.gpg = {
    enable = lib.mkEnableOption "GPG encryption system";
  };

  config = lib.mkIf cfg-gpg.enable {
    home-manager.users.${userName} =
      { config, ... }:
      {
        programs.gpg = {
          enable = true;
          homedir = "${config.home.homeDirectory}/.local/share/gnupg";
        };

        services.gpg-agent = {
          enable = true;
          enableSshSupport = true;
          defaultCacheTtl = 43200;
          maxCacheTtl = 43200;
          pinentry.package = pkgs.pinentry-tty;
        };
      };
    services.pcscd.enable = true;
  };
}
