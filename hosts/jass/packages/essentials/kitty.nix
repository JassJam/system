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
    };

    catppuccin.kitty = cfg-catppuccin;

    home.sessionVariables.TERMINAL = "${pkgs.kitty}/bin/kitty";
  };
}
