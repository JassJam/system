{
  lib,
  config,
  pkgs,
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
    home.packages = with pkgs; [
      powershell
    ];
  };
}
