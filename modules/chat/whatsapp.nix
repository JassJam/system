{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-whatsapp = config.chat.whatsapp;
in
{
  options.chat.whatsapp = {
    enable = lib.mkEnableOption "WhatsApp desktop client via WhatsApp Web wrapper.";
  };

  config = lib.mkIf cfg-whatsapp.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        karere
      ];
    };
  };
}
