{
  home.file = {
    ".config/bspwm/bspwmrc" = {
      source = ./bspwmrc;
      executable = true;
    };
    ".config/sxhkd/sxhkdrc".source = ./sxhkrc;
    ".config/picom/picom.conf".source = ./picom.conf;
    ".config/polybar/config.ini".source = ./polybar-config.ini;
  };

  imports = [
    ./sxhkd
  ];
}
