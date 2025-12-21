{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-picom = config.system.x11.screen.picom;
in
{
  options.system.x11.screen.picom = {
    enable = lib.mkEnableOption "Enable picom compositor.";
    config = lib.mkOption {
      type = lib.types.path;
      default = ./picom.conf;
      description = "Path to the picom configuration file.";
    };
  };

  config = lib.mkIf cfg-picom.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        picom
      ];

      file = {
        ".config/picom/picom.conf".source = cfg-picom.config;
      };
    };
  };
}
