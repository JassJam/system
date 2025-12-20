{
  lib,
  config,
  pkgs,
  userName,
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
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        ncdu
      ];
    };
  };
}
