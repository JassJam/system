{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-epiphany = config.browsers.epiphany;
in
{
  options.browsers.epiphany = {
    enable = lib.mkEnableOption "Enable Epiphany Browser (GNOME Web)";
  };

  config = lib.mkIf cfg-epiphany.enable {
    home.packages = with pkgs; [
      epiphany
    ];
  };
}
