{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-ninja = config.coding.tools.ninja;
in
{
  options.coding.tools.ninja = {
    enable = lib.mkEnableOption "Install Ninja build system.";
  };

  config = lib.mkIf cfg-ninja.enable {
    home.packages = [
      pkgs.ninja
    ];
  };
}
