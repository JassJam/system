{
  imports = [
    # themings
    ./catppuccin.nix

    # window switchers
    ./rofi.nix

    # clipboard managers
    ./cliphist.nix
    
    # terminal emulators + shells + extras
    ./alacritty.nix
    ./kitty.nix
    ./zsh.nix
    ./btop.nix

    # file managers
    ./yazi.nix
    ./gitui.nix

    # disk usage analyzers
    ./ncdu.nix

    # touchpad gestures
    ./fusuma.nix
  ];
}
