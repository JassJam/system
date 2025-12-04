{
  lib,
  config,
  pkgs,
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
    home.packages = [
      pkgs.cmake
    ];
  };
}
