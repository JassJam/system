{
  lib,
  pkgs,
  config,
  userName,
  ...
}:
let
  cfg-wayland = config.system.wayland;
in
{
  options.system.wayland = {
    enable = lib.mkEnableOption "Enable Wayland windowing system.";
  };

  imports = [
    ./wm
  ];

  config = lib.mkIf cfg-wayland.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        xwayland
        qt5.qtwayland
      ];
    };
  };
}
