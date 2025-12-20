{
  lib,
  config,
  pkgs,
  userName,
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
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        epiphany
      ];
    };
  };
}
