{
  inputs,
  lib,
  config,
  userName,
  ...
}:
let
  cfg-catppuccin = config.essentials.theming.catppuccin;
in
{
  options.essentials.theming.catppuccin = {
    enable = lib.mkEnableOption "Enable Catppuccin theming";
    flavor = lib.mkOption {
      type = lib.types.enum [
        "latte"
        "frappe"
        "macchiato"
        "mocha"
      ];
      default = "mocha";
      description = "Choose your Catppuccin flavor.";
    };
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
      default = "mauve";
      description = "Choose your Catppuccin accent color.";
    };
  };

  config = lib.mkIf cfg-catppuccin.enable {
    home-manager.users.${userName} = {
      catppuccin = {
        enable = true;
        flavor = cfg-catppuccin.flavor;
        accent = cfg-catppuccin.accent;
      };
    };
  };
}
