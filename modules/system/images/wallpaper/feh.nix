{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-feh = config.system.images.wallpaper.feh;
in
{
  options.system.images.wallpaper.feh = {
    enable = lib.mkEnableOption "Enable feh wallpaper setter.";
  };

  config = lib.mkIf cfg-feh.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        feh
      ];
    };
  };
}
