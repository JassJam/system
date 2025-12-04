{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      windowManager.bspwm = {
        enable = true;
      };
      displayManager.startx = {
        enable = true;
        generateScript = true;
      };
    };

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.bash}/bin/bash -c 'clear && ${pkgs.tuigreet}/bin/tuigreet --time --cmd startx'";
          user = "greeter";
        };
      };
    };

    picom = {
      enable = true;
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

  environment.systemPackages = with pkgs; [
    xsecurelock
    xautolock
  ];

  environment.sessionVariables = {
    XSECURELOCK_SAVER = "saver_blank";
    XSECURELOCK_AUTH = "auth_x11";
    XSECURELOCK_DATETIME_FORMAT = "[%Y-%m-%d %H:%M:%S]";
    XSECURELOCK_BLANK_TIMEOUT = "1";
    XSECURELOCK_DIM_TIME_MS = "3000";
    XSECURELOCK_PASSWORD_PROMPT = "kaomoji";
    XSECURELOCK_FONT = "Unifont:size=16";
    XSECURELOCK_SHOW_DATETIME = "1";
    XSECURELOCK_SHOW_USERNAME = "1";
    XSECURELOCK_SHOW_HOSTNAME = "1";
  };
}
