{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg-screen = config.system.screen;
in
{
  options.system.screen = {
    bspwm = {
      enable = lib.mkEnableOption "Enable bspwm window manager.";
    };

    x11 = true;
    wayland = false;
  };

  config = lib.mkIf cfg-screen.bspwm.enable {
    home.packages = with pkgs; [
      bspwm
    ];
  };
}
