{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-steam = config.fun.gaming.steam;
in
{
  options.fun.gaming.steam = {
    enable = lib.mkEnableOption "Steam gaming platform.";
  };

  config = lib.mkIf cfg-steam.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
