{ pkgs, ... }:
[
  {
    geometry-corner-radius =
      let
        radius = 12.0;
      in
      {
        bottom-left = radius;
        bottom-right = radius;
        top-left = radius;
        top-right = radius;
      };
    clip-to-geometry = true;
    draw-border-with-background = false;
  }

  {
    matches = [
      { is-floating = true; }
    ];
    shadow.enable = true;
  }

  {
    focus-ring = {
      active.color = "#be3cd5bc";
      inactive.color = "#3d1255bc";
    };
    border = {
      active.color = "#be3cd5bc";
      inactive.color = "#3d1255bc";
    };
    shadow = {
      color = "rgba(141, 72, 136, 0.26)";
    };
    tab-indicator = {
      active.color = "#be3cd5bc";
      inactive.color = "#3d1255bc";
    };
  }

  # floating windows class
  {
    matches = [
      { app-id = "floating"; }
    ];
    open-floating = true;
    default-floating-position = {
      x = 0;
      y = 0;
      relative-to = "top";
    };
    default-window-height = {
      proportion = 0.6;
    };
    default-column-width = {
      proportion = 0.6;
    };
  }

  # firefox picture-in-picture window
  {
    matches = [
      {
        app-id = "firefox$";
        title = "^Picture-in-Picture$";
      }
    ];
    open-floating = true;
    default-floating-position = {
      x = 32;
      y = 32;
      relative-to = "bottom-right";
    };
  }
]
