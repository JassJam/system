{
  lib,
  pkgs,
  config,
  userName,
  ...
}:
let
  cfg-bspwm = config.system.x11.window-manager.bspwm;
in
{
  options.system.x11.window-manager.bspwm = {
    enable = lib.mkEnableOption "Enable bspwm window manager.";
    tuigreet-lockscreen = lib.mkEnableOption "Enable bspwm lock screen with tuigreet.";
  };

  config = lib.mkIf cfg-bspwm.enable {
    home-manager.users.${userName}.home = {
      packages =
        with pkgs;
        [
          bspwm
        ]
        ++ lib.optionals cfg-bspwm.tuigreet-lockscreen [
          tuigreet
        ];

      file = {
        ".config/bspwm/bspwmrc" = {
          source = ./config.sh;
          executable = true;
        };
      };
    };

    services = {
      xserver = {
        windowManager.bspwm = {
          enable = true;
        };
      };

      greetd = lib.mkIf cfg-bspwm.tuigreet-lockscreen {
        enable = true;
        settings = {
          default_session =
            let
              tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
            in
            {
              command = "${pkgs.bash}/bin/bash -c 'clear && ${tuigreet} --time --cmd startx'";
              user = "greeter";
            };
        };
      };
    };
  };
}
