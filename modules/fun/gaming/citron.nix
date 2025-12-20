{
  inputs,
  lib,
  config,
  pkgs,
  system,
  userName,
  ...
}:
let
  cfg-citron = config.fun.gaming.citron;

  citron-emu = (builtins.getAttr system inputs.liberodark-flakes.packages).citron;
in
{
  options.fun.gaming.citron = {
    enable = lib.mkEnableOption "Citron emulator for Nintendo Switch games.";
  };

  config = lib.mkIf cfg-citron.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        citron-emu
      ];
    };
  };
}
