{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-feishin = config.players.feishin;
in
{
  options.players.feishin = {
    enable = lib.mkEnableOption "Enable Feishin music player client for Navidrome/Subsonic";
  };

  config = lib.mkIf cfg-feishin.enable {
    home.packages = with pkgs; [ feishin ];
  };
}
