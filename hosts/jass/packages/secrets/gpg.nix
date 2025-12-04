{
  lib,
  config,
  pkgs,
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
    programs.gpg = {
      enable = true;
      homedir = "${config.home.homeDirectory}/.local/share/gnupg";
    };
  };
}
