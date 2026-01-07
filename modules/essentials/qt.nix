{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-qt = config.essentials.theming.qt;
  cfg-catppuccin = config.essentials.theming.catppuccin;
in
{
  options.essentials.theming.qt = {
    enable = lib.mkEnableOption "Enable Qt theming";
    
    style = lib.mkOption {
      type = lib.types.str;
      default = "kvantum";
      description = "Qt style name";
    };
    
    platformTheme = lib.mkOption {
      type = lib.types.str;
      default = "kvantum";
      description = "Qt platform theme";
    };
  };

  config = lib.mkIf cfg-qt.enable {
    home-manager.users.${userName} = {
      qt = {
        enable = true;
        style.name = cfg-qt.style;
        platformTheme.name = cfg-qt.platformTheme;
      };

      catppuccin.kvantum = lib.mkIf cfg-catppuccin.enable {
        enable = true;
        flavor = cfg-catppuccin.flavor;
        accent = "mauve";
      };
    };
  };
}
