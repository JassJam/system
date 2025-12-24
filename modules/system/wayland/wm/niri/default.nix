{
  lib,
  config,
  pkgs,
  inputs,
  fullName,
  userName,
  system,
  ...
}:
let
  cfg-niri = config.system.wayland.window-manager.niri;

  cfg-catppuccin = config.essentials.theming.catppuccin;
  cfg-alacritty = config.essentials.terminal.alacritty;
  cfg-kitty = config.essentials.terminal.kitty;
  terminal-backend =
    if cfg-alacritty.enable then
      "${pkgs.alacritty}/bin/alacritty"
    else if cfg-kitty.enable then
      "${pkgs.kitty}/bin/kitty"
    else
      "${pkgs.xterm}/bin/xterm";

  has-no-lockscreen = !cfg-niri.tuigreet-lockscreen;
in
{
  options.system.wayland.window-manager.niri = {
    enable = lib.mkEnableOption "Enable Niri window manager.";

    tuigreet-lockscreen = lib.mkEnableOption "Enable Niri lock screen with tuigreet.";

    screencast = lib.mkEnableOption "Enable screencast support for Niri.";

    settings = lib.mkOption {
      type = lib.types.path;
      description = "Path to a Nix file defining Niri key settings.";
      default = ./settings/default.nix;
    };
  };

  config = lib.mkIf cfg-niri.enable {
    home-manager.users.${userName} =
      { pkgs, config, ... }:
      {
        programs.niri = {
          enable = true;
          settings = import cfg-niri.settings {
            inherit
              lib
              config
              pkgs
              inputs
              fullName
              userName
              system
              ;
          };
        };

        home.packages =
          with pkgs;
          [
            xwayland-satellite
          ]
          ++ lib.optionals cfg-niri.tuigreet-lockscreen [
            tuigreet
          ]
          ++ lib.optionals cfg-niri.screencast [
            xdg-desktop-portal-gnome
          ];
      };

    services = {
      greetd = lib.mkIf cfg-niri.tuigreet-lockscreen {
        enable = true;
        settings =
          let
            tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
          in
          {
            default_session = {
              command = "${pkgs.bash}/bin/bash -c 'clear && ${tuigreet} --time --cmd niri-session'";
              user = "greeter";
            };
          };
      };
    };

    # always start niri-session for the user if no lockscreen is used
    systemd.user.services.niri-session = lib.mkIf has-no-lockscreen {
      description = "Niri session for greetd/tuigreet";
      after = [ "graphical-session.target" ];
      wantedBy = [ "default.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.bash}/bin/bash -c 'export XDG_SESSION_TYPE=wayland && exec ${pkgs.niri}/bin/niri-session'";
        Restart = "on-failure";
      };
    };
  };
}
