{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-gajim = config.chat.gajim;
in
{
  options.chat.gajim = {
    enable = lib.mkEnableOption "Gajim instant messenger";
  };

  config = lib.mkIf cfg-gajim.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        gajim
      ];
    };
  };
}
