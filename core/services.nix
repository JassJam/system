{ pkgs, ... }:
{
  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.bash}/bin/bash -c 'clear && ${pkgs.tuigreet}/bin/tuigreet --time --cmd startx'";
          user = "greeter";
        };
      };
    };

    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    pipewire = {
      enable = true;
    };

    logind = {
      settings.Login.HandleLidSwitchExternalPower = "ignore";
    };
  };

  # Enable XDG portals so GTK theme is exposed to all apps
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };
}
