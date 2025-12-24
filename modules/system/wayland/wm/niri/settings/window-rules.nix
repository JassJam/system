{ pkgs, ... }:
[
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
