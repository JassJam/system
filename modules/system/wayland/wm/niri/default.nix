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
in
{
  options.system.wayland.window-manager.niri = {
    enable = lib.mkEnableOption "Enable Niri window manager.";

    tuigreet-lockscreen = lib.mkEnableOption "Enable Niri lock screen with tuigreet.";
  };

  config = lib.mkIf cfg-niri.enable {
    home-manager.users.${userName} = {
      programs.niri = {
        enable = true;

        settings = {
          binds = {
            "Mod+D".action.spawn = [
              "rofi"
              "-show"
              "drun"
            ];
          };
        };
      };

      home.packages =
        with pkgs;
        [ ]
        ++ lib.optionals cfg-niri.tuigreet-lockscreen [
          tuigreet
        ];
    };

    services = lib.mkIf cfg-niri.tuigreet-lockscreen {
      greetd = {
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
  };
}
