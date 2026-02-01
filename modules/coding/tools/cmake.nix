{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-cmake = config.coding.tools.cmake;
in
{
  options.coding.tools.cmake = {
    enable = lib.mkEnableOption "Install CMake build system.";
  };

  config = lib.mkIf cfg-cmake.enable {
    home-manager.users.${userName}.home = {
      packages = [
        pkgs.cmake
        pkgs.gnumake
        pkgs.pkg-config
      ];
    };
  };
}
