{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-nicotine-plus = config.fun.other.nicotine-plus;
in
{
  options.fun.other.nicotine-plus = {
    enable = lib.mkEnableOption "Nicotine+ client for the Soulseek peer-to-peer file sharing network.";
  };

  config = lib.mkIf cfg-nicotine-plus.enable {
    home.packages = with pkgs; [
      nicotine-plus
    ];
  };
}
