{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-vesktop = config.chat.vesktop;
  cfg-catppuccin = config.essentials.theming.catppuccin;
in
{
  options.chat.vesktop = {
    enable = lib.mkEnableOption "Vesktop chat client";
  };

  config = lib.mkIf cfg-vesktop.enable {
    home-manager.users.${userName} = {
      programs.vesktop = {
        enable = true;
        settings = {
          autoUpdate = false;
          autoUpdateNotification = false;
          notifyAboutUpdates = false;
          useQuickCss = true;
          disableMinSize = true;
          enabledThemes = [ ];
          discordBranch = "stable";
          arRPC = "on";
        };
      };

      catppuccin.vesktop = cfg-catppuccin;
    };
  };
}
