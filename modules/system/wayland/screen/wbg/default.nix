{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-wbg = config.system.wayland.screen.wbg;
in
{
  options.system.wayland.screen.wbg = {
    enable = lib.mkEnableOption "Enable wbg for Wayland wallpapers.";
  };

  config = lib.mkIf cfg-wbg.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        wbg
      ];
    };
  };
}
