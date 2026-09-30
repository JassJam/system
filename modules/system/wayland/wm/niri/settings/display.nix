{ pkgs, ... }:
{
  "eDP-1" = {
    scale = 1.25;
    mode = {
        width = 2560;
        height = 1600;
        refresh = 165.0;
    };
  };

  "HDMI-A-1" = {
    mode = {
        width = 1920;
        height = 1080;
        refresh = 165.0;
    };
  };
}
