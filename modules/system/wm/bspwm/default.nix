{
  lib,
  pkgs,
  config,
  userName,
  ...
}:
let
  cfg-bspwm = config.system.window-manager.bspwm;
in
{
  options.system.window-manager = {
    bspwm = {
      enable = lib.mkEnableOption "Enable bspwm window manager.";
    };

    x11 = true;
    wayland = false;
  };

  config = lib.mkIf cfg-bspwm.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        bspwm
      ];

      file = {
        ".config/bspwm/bspwmrc" = {
          source = ./config.sh;
          executable = true;
        };
      };
    };
  };
}
