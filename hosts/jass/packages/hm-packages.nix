{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # bswpm essentials
    bspwm
    sxhkd

    # compositor
    picom

    # status bar
    polybar

    # wallpaper setter
    feh

    # to query node's title by id
    xtitle

    # volume control
    pamixer

    # brightness control
    brightnessctl

    # screenshot
    maim

    # clipboard
    xclip

    # nix formatter
    nixfmt-rfc-style
  ];

  programs.home-manager.enable = true;

  imports = [
    ./secrets
    ./essentials
    ./players
    ./coding
    ./browsers
    ./chat
    ./fun
    ./other
  ];

  essentials = {
    # catppuccin theming
    theming.catppuccin.enable = true;

    # yazi file manager
    file-manager.yazi.enable = true;

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

      # rust compiler + cargo
      rust.compiler = true;
      rust.cargo = true;
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

      # docker
      docker.enable = true;

      # insomnia
      insomnia.enable = true;

      # mockoon
      mockoon.enable = true;
    };
  };

  chat = {
    # xmpp client
    gajim.enable = true;
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
  };
}
