{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-xtitle = config.system.other.xtitle;
in
{
  options.system.other.xtitle = {
    enable = lib.mkEnableOption "Enable xtitle window title utility.";
  };

  config = lib.mkIf cfg-xtitle.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        xtitle
      ];
    };
  };
}
