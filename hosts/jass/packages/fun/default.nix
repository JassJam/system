{
  imports = [
    # gaming
    # switch emulator
    ./gaming/citron.nix
    # snes emulator
    ./gaming/snes9x.nix
    # minecraft modpack launcher
    ./gaming/prismlauncher.nix
    # steam -> nixos-packages
    # ./gaming/steam.nix

    # other
    # p2p soulseek client
    ./other/nicotine-plus.nix
    # torrent client
    ./other/qbittorrent.nix
    # homestuck viewer
    ./other/homestuck.nix
  ];
}
