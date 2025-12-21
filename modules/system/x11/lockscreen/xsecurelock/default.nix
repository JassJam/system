{
  lib,
  pkgs,
  config,
  userName,
  ...
}:
let
  cfg-xsecurelock = config.system.x11.lockscreen.xsecurelock;
in
{
  options.system.x11.lockscreen.xsecurelock = {
    enable = lib.mkEnableOption "Enable xsecurelock screen locker.";
  };

  config = lib.mkIf cfg-xsecurelock.enable {
    environment.systemPackages = with pkgs; [
      xsecurelock
    ];

    environment.sessionVariables = {
      XSECURELOCK_SAVER = "saver_blank";
      XSECURELOCK_AUTH = "auth_x11";
      XSECURELOCK_DATETIME_FORMAT = "[%Y-%m-%d %H:%M:%S]";
      XSECURELOCK_BLANK_TIMEOUT = "1";
      XSECURELOCK_DIM_TIME_MS = "3000";
      XSECURELOCK_PASSWORD_PROMPT = "kaomoji";
      XSECURELOCK_FONT = "Unifont:size=16";
      XSECURELOCK_SHOW_DATETIME = "1";
      XSECURELOCK_SHOW_USERNAME = "1";
      XSECURELOCK_SHOW_HOSTNAME = "1";
    };
  };
}
