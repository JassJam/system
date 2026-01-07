{
  inputs,
  system,
  config,
  userName,
  hostName,
  fullName,
  ...
}:
{
  imports = [
    ./fonts.nix
    ./secrets
    ./nixos
  ];

  system = {
    # x11 = {
    #   enable = true;

    #   lockscreen = {
    #     # xautolock screen locker
    #     xautolock.enable = true;

    #     # xsecurelock screen locker
    #     xsecurelock.enable = true;
    #   };

    #   # bspwm window manager
    #   window-manager.bspwm = {
    #     enable = true;
    #     tuigreet-lockscreen = true;
    #   };

    #   # sxhkd hotkey daemon
    #   hotkey-daemon.sxhkd = {
    #     enable = true;
    #   };

    #   screen = {
    #     # picom compositor for window effects
    #     picom.enable = true;

    #     # polybar status bar
    #     polybar.enable = true;
    #   };
    # };

    wayland = {
      enable = true;

      # niri window manager
      window-manager.niri = {
        enable = true;
        tuigreet-lockscreen = true;
        #
        screencast = true;

        # waybar status bar
        startup-commands = [
          {
            command = [
              "waybar"
            ];
          }
        ];
      };

      screen = {
        # waybar status bar
        waybar.enable = true;

        # wpaperd wallpaper daeom
        wpaperd = {
          enable = true;
          settings = {
            eDP-1 = {
              path = "~/images/wallpapers";
              apply-shadow = true;
              duration = "10m";
              sorting = "random";
            };
          };
        };
      };
    };

    # dunst notification daemon
    notifications.dunst = {
      enable = true;
    };

    # docker virtualization
    virtualization.docker = {
      enable = true;
    };

    audio = {
      # pamixer volume control utility
      pamixer = {
        enable = true;
      };
    };

    drivers = {
      # ASUS laptop support
      asus.enable = true;

      # AMD graphics drivers
      amd.enable = true;

      # NVIDIA graphics drivers with PRIME offloading
      nvidia = {
        enable = true;
        prime = {
          enable = true;
          amdBusID = "PCI:5:0:0";
          nvidiaBusID = "PCI:1:0:0";
        };
      };
    };

    images = {
      # # maim screenshot utility
      # screenshot.maim = {
      #   enable = true;
      # };

      # # feh wallpaper setter
      # wallpaper.feh = {
      #   enable = true;
      # };
    };

    other = {
      # clipboard management with xclip
      xclip = {
        enable = true;
      };

      # screen brightness control with brightnessctl
      brightnessctl = {
        enable = true;
      };

      # nixfmt for formatting Nix files
      nixfmt = {
        enable = true;
      };

      # xtitle for window title management
      xtitle = {
        enable = true;
      };
    };
  };

  essentials = {
    # catppuccin theming
    theming.catppuccin.enable = true;

    # yazi file manager
    file-manager = {
      # git tui
      # gitgui.enable = true;

      # yazi tui file manager
      yazi = {
        enable = true;
        # gitgui = true;
      };

      # nautilus GUI file manager for file picker dialogs
      nautilus.enable = true;
    };

    # kitty terminal with zsh
    terminal.kitty.enable = true;
    shell.zsh.enable = true;
    terminal.btop.enable = true;

    # rofi window switcher
    window-switcher.rofi.enable = true;
    cliphist.enable = true;

    # ncdu disk usage analyzer
    disk-usage.ncdu.enable = true;

    # fusuma touchpad gestures
    gestures.fusuma.enable = false;
  };

  players = {
    # mpd.enable = true;
    mpv.enable = true;
    # mpc.enable = true;
    # ncmpcpp.enable = true;
    feishin.enable = true;
  };

  browsers = {
    # gnome browser
    epiphany.enable = true;
    # firefox browser
    firefox.enable = true;
  };

  coding = {
    editors = {
      # vscode, text editor
      vscode.enable = true;

      # c++ ide
      jetbrains.clion = true;
      # java ide
      jetbrains.idea-community = true;
      # web ide
      jetbrains.webstorm = true;
    };

    langs = {
      # C# + powershell
      dotnet.enable = true;
      powershell.enable = true;

      # java
      java.enable = true;

      # nodejs
      nodejs.enable = true;

      # # rust compiler + cargo
      # rust.compiler = true;
      # rust.cargo = true;
    };

    tools = {
      # C++
      clang = {
        enable = true;
        enable-tools = true;
        enable-libllvm = true;
      };
      cmake.enable = true;
      ninja.enable = true;
      valgrind.enable = true;

      # direnv
      direnv.enable = true;

      # insomnia
      insomnia.enable = true;

      # mockoon
      mockoon.enable = true;
    };
  };

  chat = {
    # matrix client
    element.enable = true;
    # corporate chat clients
    slack.enable = true;
    # general chat clients
    telegram.enable = true;
    vesktop.enable = true;
  };

  fun = {
    gaming = {
      # switch emulator
      citron.enable = true;

      # snes emulator
      snes9x.enable = true;

      # minecraft modpack launcher
      prismlauncher.enable = true;

      # steam
      steam.enable = true;

      # celeste olympus mod launcher
      olympus.enable = true;
    };

    other = {
      # p2p soulseek client for music sharing
      nicotine-plus.enable = true;

      # torrent client
      qbittorrent.enable = true;

      # homestuck viewer
      homestuck.enable = true;
    };
  };

  secrets = {
    # enable gpg
    gpg.enable = true;

    # enable ssh and music server config
    ssh = {
      enable = true;
      enable-music-server = true;
    };

    # password management
    password-store.enable = true;

    # git version control
    vcs.git = {
      enable = true;
      use-secrets = true;
    };

    # vpn services
    openfortivpn.enable = true;
  };
}
