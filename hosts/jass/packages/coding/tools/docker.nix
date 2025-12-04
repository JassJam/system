{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-docker = config.coding.tools.docker;
in
{
  options.coding.tools.docker = {
    enable = lib.mkEnableOption "Install Docker for container management.";
  };

  config = lib.mkIf cfg-docker.enable {
    home.packages = [
      pkgs.docker
    ];
  };
}
