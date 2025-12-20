{
  lib,
  pkgs,
  config,
  userName,
  ...
}:
let
  cfg-dunst = config.system.notifications.dunst;
in
{
  options.system.notifications.dunst = {
    enable = lib.mkEnableOption "Enable dunst notification daemon.";
  };

  config = lib.mkIf cfg-dunst.enable {
    home-manager.users.${userName} = {
      services = {
        dunst.enable = true;
      };
    };
  };
}
