{
  imports = [
    # gaming
    # switch emulator
    ./gaming/citron.nix
    # snes emulator
    ./gaming/snes9x.nix
    # minecraft modpack launcher
    ./gaming/prismlauncher.nix
    # steam
    ./gaming/steam.nix
    # celeste olympus mod launcher
    ./gaming/olympus.nix

    # other
    # p2p soulseek client
    ./other/nicotine-plus.nix
    # torrent client
    ./other/qbittorrent.nix
    # homestuck viewer
    ./other/homestuck.nix
  ];
}
