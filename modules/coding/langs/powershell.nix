{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-powershell = config.coding.langs.powershell;
in
{
  options.coding.langs.powershell = {
    enable = lib.mkEnableOption "Install PowerShell for scripting and automation.";
  };

  config = lib.mkIf cfg-powershell.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        powershell
      ];
    };
  };
}
