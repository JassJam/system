{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-valgrind = config.coding.tools.valgrind;
in
{
  options.coding.tools.valgrind = {
    enable = lib.mkEnableOption "Install Valgrind programming tool for memory debugging, memory leak detection, and profiling.";
  };

  config = lib.mkIf cfg-valgrind.enable {
    home.packages = [
      pkgs.valgrind
    ];
  };
}
