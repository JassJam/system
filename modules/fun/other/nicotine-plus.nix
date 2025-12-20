{
  lib,
  config,
  pkgs,
  userName,
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
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        nicotine-plus
      ];
    };
  };
}
