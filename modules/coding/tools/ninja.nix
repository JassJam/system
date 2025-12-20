{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-ninja = config.coding.tools.ninja;
in
{
  options.coding.tools.ninja = {
    enable = lib.mkEnableOption "Install Ninja build system.";
  };

  config = lib.mkIf cfg-ninja.enable {
    home-manager.users.${userName}.home = {
      packages = [
        pkgs.ninja
      ];
    };
  };
}
