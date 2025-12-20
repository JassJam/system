{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-mockoon = config.coding.tools.mockoon;
in
{
  options.coding.tools.mockoon = {
    enable = lib.mkEnableOption "Install Mockoon API mocking tool.";
  };

  config = lib.mkIf cfg-mockoon.enable {
    home-manager.users.${userName}.home = {
      packages = [
        pkgs.mockoon
      ];
    };
  };
}
