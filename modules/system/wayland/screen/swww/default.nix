{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-swww = config.system.wayland.screen.swww;
in
{
  options.system.wayland.screen.swww = {
    enable = lib.mkEnableOption "Enable swww for Wayland wallpapers and notifications.";
  };

  config = lib.mkIf cfg-swww.enable {
    home-manager.users.${userName} = {
      services.swww = {
        enable = true;
      };
    };
  };
}
