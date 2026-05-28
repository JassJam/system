{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-ccache = config.coding.tools.ccache;
in
{
  options.coding.tools.ccache = {
    enable = lib.mkEnableOption "Install ccache build cache system.";
  };

  config = lib.mkIf cfg-ccache.enable {
    home-manager.users.${userName}.home = {
      packages = [
        pkgs.ccache
      ];
    };
  };
}
