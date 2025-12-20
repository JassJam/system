{
  imports = [
    # music players
    # music player daemon
    ./mpd.nix

    # ncmpcpp client
    ./ncmpcpp.nix
    # mpv media player
    ./mpv.nix
    # mpc client
    ./mpc.nix

    # feishin client for navidrome/subsonic
    ./feishin.nix
  ];
}
