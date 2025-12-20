{
  lib,
  config,
  pkgs,
  userName,
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
    home-manager.users.${userName}.home = {
      packages = with pkgs; [ mpc ];
    };
  };
}
