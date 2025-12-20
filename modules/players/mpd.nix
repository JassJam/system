{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-mpd = config.players.mpd;
in
{
  options.players.mpd = {
    enable = lib.mkEnableOption "Enable MPD music player daemon";
    music-directory = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/music";
      description = "Directory where music is stored for MPD.";
    };
  };

  config = lib.mkIf cfg-mpd.enable {
    home-manager.users.${userName}.home = {
      services.mpd = {
        enable = true;
        musicDirectory = cfg-mpd.music-directory;
      };
    };
  };
}
