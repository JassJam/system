{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-pamixer = config.system.audio.pamixer;
in
{
  options.system.audio.pamixer = {
    enable = lib.mkEnableOption "Enable pamixer volume control utility.";
  };

  config = lib.mkIf cfg-pamixer.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        pamixer
      ];
    };
  };
}
