{
  lib,
  pkgs,
  config,
  userName,
  ...
}:
let
  cfg-x11 = config.system.x11;
in
{
  options.system.x11 = {
    enable = lib.mkEnableOption "Enable X11 windowing system.";
  };

  imports = [
    ./wm
    ./screen
    ./lockscreen
    ./hotkey-daemon
  ];

  config = lib.mkIf cfg-x11.enable {

    services = {
      xserver = {
        enable = true;
        displayManager.startx = {
          enable = true;
          generateScript = true;
        };
      };
    };
  };
}
