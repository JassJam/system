{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-waybar = config.system.wayland.screen.waybar;
in
{
  options.system.wayland.screen.waybar = {
    enable = lib.mkEnableOption "Enable Waybar status bar.";
    config = lib.mkOption {
      type = lib.types.path;
      default = ./settings.nix;
      description = "Path to the Waybar configuration file.";
    };
    stylesheet = lib.mkOption {
      type = lib.types.path;
      default = ./style.css;
      description = "Path to the Waybar stylesheet.";
    };
  };

  config = lib.mkIf cfg-waybar.enable {
    home-manager.users.${userName} = {
      programs.waybar = {
        enable = true;
        settings = import cfg-waybar.config;
        style = builtins.readFile cfg-waybar.stylesheet;
      };
    };
  };
}
