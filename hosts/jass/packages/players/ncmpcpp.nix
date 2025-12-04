{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-ncmpcpp = config.players.ncmpcpp;
  cfg-mpd = config.players.mpd;
in
{
  options.players.ncmpcpp = {
    enable = lib.mkEnableOption "Enable MPC client for MPD";
  };

  config = lib.mkIf cfg-ncmpcpp.enable {
    programs.ncmpcpp = {
      enable = true;
      mpdMusicDir = cfg-mpd.music-directory;
    };
  };
}
