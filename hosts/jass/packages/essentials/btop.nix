{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-btop = config.essentials.terminal.btop;
  cfg-catppuccin = config.essentials.theming.catppuccin;
in
{
  options.essentials.terminal.btop = {
    enable = lib.mkEnableOption "Enable btop resource monitor";
  };

  config = lib.mkIf cfg-btop.enable {
    programs.btop = {
      enable = true;
    };

    catppuccin.btop = cfg-catppuccin;
  };
}
