{
  lib,
  pkgs,
  config,
  userName,
  ...
}:
let
  cfg-xautolock = config.system.x11.lockscreen.xautolock;
in
{
  options.system.x11.lockscreen.xautolock = {
    enable = lib.mkEnableOption "Enable xautolock screen locker.";
  };

  config = lib.mkIf cfg-xautolock.enable {
    environment.systemPackages = with pkgs; [
      xautolock
    ];
  };
}
