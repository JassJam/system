{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-ncdu = config.essentials.disk-usage.ncdu;
in
{
  options.essentials.disk-usage.ncdu = {
    enable = lib.mkEnableOption "Enable ncdu disk usage analyzer";
  };

  config = lib.mkIf cfg-ncdu.enable {
    home.packages = with pkgs; [
      ncdu
    ];
  };
}
