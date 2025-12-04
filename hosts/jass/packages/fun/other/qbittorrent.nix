{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-qbittorrent = config.fun.other.qbittorrent;
in
{
  options.fun.other.qbittorrent = {
    enable = lib.mkEnableOption "qBittorrent, a free and open-source BitTorrent client.";
  };

  config = lib.mkIf cfg-qbittorrent.enable {
    home.packages = with pkgs; [
      qbittorrent
    ];
  };
}
