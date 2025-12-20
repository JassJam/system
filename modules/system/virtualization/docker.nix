{
  lib,
  pkgs,
  config,
  userName,
  ...
}:
let
  cfg-docker = config.system.virtualization.docker;
in
{
  options.system.virtualization.docker = {
    enable = lib.mkEnableOption "Enable Docker virtualization.";
  };

  config = lib.mkIf cfg-docker.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
    };

    users.users.${userName}.extraGroups = [
      "docker"
    ];

    home-manager.users.${userName}.home = {
      packages = [
        pkgs.docker
      ];
    };
  };
}
