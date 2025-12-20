{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-telegram = config.chat.telegram;
in
{
  options.chat.telegram = {
    enable = lib.mkEnableOption "Telegram desktop client";
  };

  config = lib.mkIf cfg-telegram.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        telegram-desktop
      ];
    };
  };
}
