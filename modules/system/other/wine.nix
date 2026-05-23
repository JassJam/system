{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-wine = config.system.other.wine;
in
{
  options.system.other.wine = {
    enable = lib.mkEnableOption "Enable wine";
  };

  config = lib.mkIf cfg-wine.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        # support 32-bit only
        wine

        # winetricks (all versions)
        winetricks
      ];
    };
  };
}
