{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-polybar = config.system.screen.polybar;
in
{
  options.system.screen.polybar = {
    enable = lib.mkEnableOption "Enable Polybar status bar.";
    config = lib.mkOption {
      type = lib.types.path;
      default = ./polybar-config.ini;
      description = "Path to the Polybar configuration file.";
    };
  };

  config = lib.mkIf cfg-polybar.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        polybar
      ];

      file = {
        ".config/polybar/config.ini".source = cfg-polybar.config;
      };
    };

    services.picom = {
      enable = true;
    };
  };
}
