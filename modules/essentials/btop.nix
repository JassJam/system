{
  lib,
  config,
  pkgs,
  userName,
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
    home-manager.users.${userName} = {
      programs.btop = {
        enable = true;
      };

      catppuccin.btop = {
        enable = cfg-catppuccin.enable;
        flavor = cfg-catppuccin.flavor;
      };
    };
  };
}
