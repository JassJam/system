{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-direnv = config.coding.tools.direnv;
in
{
  options.coding.tools.direnv = {
    enable = lib.mkEnableOption "Install direnv tool for managing environment variables per project.";
  };

  config = lib.mkIf cfg-direnv.enable {
    home-manager.users.${userName} = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
