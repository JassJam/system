{
  lib,
  config,
  pkgs,
  exts,
  ...
}:
let
  cfg-password-store = config.secrets.password-store;
in
{
  options.secrets.password-store = {
    enable = lib.mkEnableOption "Password Store for managing passwords securely";
  };

  config = lib.mkIf cfg-password-store.enable {
    programs.password-store = {
      enable = true;
      settings = {
        PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.local/share/pass";
        PASSWORD_STORE_CLIP_TIME = "15";
      };
      package = pkgs.pass.withExtensions (exts: [
        exts.pass-otp
      ]);
    };
  };
}
