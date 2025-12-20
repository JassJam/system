{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-snes9x = config.fun.gaming.snes9x;
in
{
  options.fun.gaming.snes9x = {
    enable = lib.mkEnableOption "SNES9x emulator for Super Nintendo games.";
  };

  config = lib.mkIf cfg-snes9x.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        snes9x
      ];
    };
  };
}
