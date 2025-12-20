{
  lib,
  config,
  pkgs,
  userName,
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
    home-manager.users.${userName}.home = {
      programs.ncmpcpp = {
        enable = true;
        mpdMusicDir = cfg-mpd.music-directory;
      };
    };
  };
}
