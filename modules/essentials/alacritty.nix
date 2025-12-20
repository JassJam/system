{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-alacritty = config.essentials.terminal.alacritty;
  cfg-catppuccin = config.essentials.theming.catppuccin;
in
{
  options.essentials.terminal.alacritty = {
    enable = lib.mkEnableOption "Enable Alacritty terminal emulator";
  };

  config = lib.mkIf cfg-alacritty.enable {
    home-manager.users.${userName} = {
      programs.alacritty = {
        enable = true;
        settings = {
          terminal.shell = "${pkgs.zsh}/bin/zsh";
          font.normal.family = "JetBrainsMono Nerd Font";
          window.padding = {
            x = 15;
            y = 15;
          };
        };
      };

      catppuccin.alacritty = cfg-catppuccin;

      sessionVariables.TERMINAL = "${pkgs.kitty}/bin/alacritty";
    };
  };
}
