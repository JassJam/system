{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-maim = config.system.images.screenshot.maim;
in
{
  options.system.images.screenshot.maim = {
    enable = lib.mkEnableOption "Enable maim screenshot tool.";
  };

  config = lib.mkIf cfg-maim.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        maim
      ];
    };
  };
}
