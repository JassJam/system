{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg = config.system.cursor.catppuccin;
  cfg-catppuccin = config.essentials.theming.catppuccin;
in
{
  options.system.cursor.catppuccin = {
    enable = lib.mkEnableOption "Enable Catppuccin cursor theme";
    accent = lib.mkOption {
      type = lib.types.enum [
        "rosewater"
        "flamingo"
        "pink"
        "mauve"
        "red"
        "maroon"
        "peach"
        "yellow"
        "green"
        "teal"
        "blue"
        "sky"
        "lavender"
      ];
      default = cfg-catppuccin.accent;
      description = "Choose your Catppuccin cursor accent color.";
    };

    flavor = lib.mkOption {
      type = lib.types.enum [
        "latte"
        "frappe"
        "macchiato"
        "mocha"
      ];
      default = cfg-catppuccin.flavor;
      description = "Choose your Catppuccin cursor flavor.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${userName} = {
      catppuccin.cursors = {
        enable = true;
        accent = cfg.accent;
        flavor = cfg.flavor;
      };
    };
  };
}
