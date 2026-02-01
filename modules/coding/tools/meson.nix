{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-meson = config.coding.tools.meson;
in
{
  options.coding.tools.meson = {
    enable = lib.mkEnableOption "Install Meson build system.";
  };

  config = lib.mkIf cfg-meson.enable {
    home-manager.users.${userName}.home = {
      packages = [
        pkgs.meson
      ];
    };
  };
}
