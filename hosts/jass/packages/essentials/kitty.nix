{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-kitty = config.essentials.terminal.kitty;
  cfg-catppuccin = config.essentials.theming.catppuccin;
in
{
  options.essentials.terminal.kitty = {
    enable = lib.mkEnableOption "Enable Kitty terminal emulator";
  };

  config = lib.mkIf cfg-kitty.enable {
    programs.kitty = {
      enable = true;
      settings = {
        window_padding_width = 15;

        shell = "${pkgs.zsh}/bin/zsh";

        background_opacity = 0.85;

        font_family = "JetBrainsMono Nerd Font";
      };
      keybindings = {
        # Enable ctrl+plus/minus for zoom (fusuma gestures send key names)
        "ctrl+shift+equal" = "change_font_size all +1.0";
        "ctrl+shift+minus" = "change_font_size all -1.0";
        "ctrl+shift+0" = "change_font_size all 0";
      };
    };

    catppuccin.kitty = cfg-catppuccin;

    home.sessionVariables.TERMINAL = "${pkgs.kitty}/bin/kitty";
  };
}
