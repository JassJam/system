{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-rofi = config.essentials.window-switcher.rofi;

  cfg-catppuccin = config.essentials.theming.catppuccin;
  cfg-alacritty = config.essentials.terminal.alacritty;
  cfg-kitty = config.essentials.terminal.kitty;
  terminal-backend =
    if cfg-alacritty.enable then
      "${pkgs.alacritty}/bin/alacritty"
    else if cfg-kitty.enable then
      "${pkgs.kitty}/bin/kitty"
    else
      "${pkgs.xterm}/bin/xterm";
in
{
  options.essentials.window-switcher.rofi = {
    enable = lib.mkEnableOption "Enable Rofi window switcher";
  };

  config = lib.mkIf cfg-rofi.enable {
    home-manager.users.${userName} = {
      programs.rofi = {
        enable = true;
        terminal = terminal-backend;
      };

      catppuccin.rofi = cfg-catppuccin;
    };
  };
}
