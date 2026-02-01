{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-conan = config.coding.tools.conan;
in
{
  options.coding.tools.conan = {
    enable = lib.mkEnableOption "Install Conan package manager.";
  };

  config = lib.mkIf cfg-conan.enable {
    home-manager.users.${userName}.home = {
      packages = [
        pkgs.conan
      ];
    };
  };
}
