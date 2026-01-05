{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-olympus = config.fun.gaming.olympus;
in
{
  options.fun.gaming.olympus = {
    enable = lib.mkEnableOption "Celeste Olympus mod launcher.";
  };

  config = lib.mkIf cfg-olympus.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        olympus
      ];
    };
  };
}
