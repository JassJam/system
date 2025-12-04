{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-insomnia = config.coding.tools.insomnia;
in
{
  options.coding.tools.insomnia = {
    enable = lib.mkEnableOption "Install Insomnia REST client for API development.";
  };

  config = lib.mkIf cfg-insomnia.enable {
    home.packages = [
      pkgs.insomnia
    ];
  };
}
