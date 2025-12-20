{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-mpv = config.players.mpv;
in
{
  options.players.mpv = {
    enable = lib.mkEnableOption "Enable MPV media player";
  };

  config = lib.mkIf cfg-mpv.enable {
    home-manager.users.${userName} = {
      programs.mpv = {
        enable = true;
      };
    };
  };
}
