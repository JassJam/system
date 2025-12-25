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

    essentials = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [
        pkgs.wl-clipboard
      ];
      description = "Essential Wayland packages to be installed system-wide.";
    };
  };

  imports = [
    ./wm
    ./screen
  ];

  config = lib.mkIf cfg-wayland.enable {
    home-manager.users.${userName}.home = {
      packages =
        with pkgs;
        [
          xwayland
          qt5.qtwayland
        ]
        ++ cfg-wayland.essentials;
    };
  };
}
