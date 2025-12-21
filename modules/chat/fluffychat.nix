{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-fluffychat = config.chat.fluffychat;
in
{
  options.chat.fluffychat = {
    enable = lib.mkEnableOption "FluffyChat MATRIX client";
  };

  config = lib.mkIf cfg-fluffychat.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        fluffychat
      ];
    };
  };
}
