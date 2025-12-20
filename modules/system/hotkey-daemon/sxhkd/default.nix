{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-sxhkd = config.system.hotkey-daemon.sxhkd;
in
{
  options.system.hotkey-daemon.sxhkd = {
    enable = lib.mkEnableOption "Enable sxhkd hotkey daemon.";
  };

  config = lib.mkIf cfg-sxhkd.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        sxhkd
      ];

      file = {
        ".config/sxhkd/sxhkdrc".source = ./scripts/sxhkd.sh;

        ".config/sxhkd/remove_desktop.sh" = {
          source = ./scripts/remove_desktop.sh;
          executable = true;
        };

        ".config/sxhkd/unhide_window.sh" = {
          source = ./scripts/unhide_window.sh;
          executable = true;
        };

        ".config/sxhkd/volume_control.sh" = {
          source = ./scripts/volume_control.sh;
          executable = true;
        };

        ".config/sxhkd/brightness_control.sh" = {
          source = ./scripts/brightness_control.sh;
          executable = true;
        };
      };
    };
  };
}
