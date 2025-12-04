{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-mpc = config.players.mpc;
  cfg-mpd = config.players.mpd;
in
{
  options.players.mpc = {
    enable = lib.mkEnableOption "Enable MPC client for MPD";
  };

  config = lib.mkIf cfg-mpc.enable {
    home.packages = with pkgs; [ mpc ];
  };
}
