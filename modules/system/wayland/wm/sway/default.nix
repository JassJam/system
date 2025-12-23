{
  lib,
  config,
  pkgs,
  inputs,
  fullName,
  userName,
  ...
}:
let
  cfg-sway = config.system.wayland.window-manager.sway;

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
  options.system.wayland.window-manager.sway = {
    enable = lib.mkEnableOption "Enable Sway window manager.";
    fancy = lib.mkEnableOption "Enable fancy Sway features like autotiling.";

    tuigreet-lockscreen = lib.mkEnableOption "Enable Sway lock screen.";
  };

  config =
    lib.mkIf cfg-sway.enable {
      security.polkit.enable = true;

      home-manager.users.${userName} =
        { pkgs, ... }:
        {
          wayland.windowManager.sway = {
            enable = true;
            wrapperFeatures.gtk = true;
            config = rec {
              modifier = "Mod4";
              terminal = terminal-backend;
              startup = [
              ];
            };
            extraOptions = [ "--unsupported-gpu" ];
          };
        }

        // lib.mkIf cfg-sway.fancy {
          home-manager.users.${userName}.programs.sway.features = {
            autotiling = true;
          };
        };
    }

    // lib.mkIf (cfg-sway.enable && cfg-sway.tuigreet-lockscreen) {
      environment.systemPackages = with pkgs; [
        tuigreet
      ];

      services = {
        greetd = {
          enable = true;
          settings = {
            default_session = {
              command = "${pkgs.bash}/bin/bash -c 'clear && ${pkgs.tuigreet}/bin/tuigreet --time --cmd sway'";
              user = "greeter";
            };
          };
        };
      };
    };
}
