{
  lib,
  config,
  pkgs,
  inputs,
  fullName,
  userName,
  system,
  ...
}:
let
  volume-step = "5%";
  backlight-step = "10%";
in
{
  # ============================================
  # WINDOWS
  # ============================================

  # Launch terminal
  "Mod+Return".action.spawn = [ "kitty" ];

  # Launch floating terminal
  "Mod+Shift+Return".action.spawn = [
    "sh"
    "-c"
    ''
      kitty --class floating-terminal
    ''
  ];

  # Close window
  "Mod+Q".action.close-window = { };

  # Kill window
  # "Mod+Shift+Q".action.spawn = [
  #   "sh"
  #   "-c"
  #   ''
  #     xdotool getactivewindow | xargs -I{} xkill -id {}
  #   ''
  # ];

  # Toggle fullscreen
  "Mod+F".action.fullscreen-window = { };
  "Mod+Shift+F".action.toggle-windowed-fullscreen = { };
  
  "Mod+Ctrl+F".action.set-window-height = "100%";
  "Mod+Alt+F".action.set-window-width = "100%";

  # Toggle floating
  # "Mod+Ctrl+Space".action.toggle-floating = { };

  # ============================================
  # NAVIGATION
  # ============================================

  # Open application launcher
  "Mod+Space".action.spawn = [
    "rofi"
    "-show"
    "drun"
  ];

  "Mod+1".action.focus-workspace = 1;
  "Mod+2".action.focus-workspace = 2;
  "Mod+3".action.focus-workspace = 3;
  "Mod+4".action.focus-workspace = 4;
  "Mod+5".action.focus-workspace = 5;
  "Mod+6".action.focus-workspace = 6;
  "Mod+7".action.focus-workspace = 7;
  "Mod+8".action.focus-workspace = 8;
  "Mod+9".action.focus-workspace = 9;
  "Mod+0".action.focus-workspace = 10;

  "Mod+Shift+1".action.move-window-to-workspace = 1;
  "Mod+Shift+2".action.move-window-to-workspace = 2;
  "Mod+Shift+3".action.move-window-to-workspace = 3;
  "Mod+Shift+4".action.move-window-to-workspace = 4;
  "Mod+Shift+5".action.move-window-to-workspace = 5;
  "Mod+Shift+6".action.move-window-to-workspace = 6;
  "Mod+Shift+7".action.move-window-to-workspace = 7;
  "Mod+Shift+8".action.move-window-to-workspace = 8;
  "Mod+Shift+9".action.move-window-to-workspace = 9;
  "Mod+Shift+0".action.move-window-to-workspace = 10;

  # Toggle overview mode
  "Mod+O".action.toggle-overview = { };

  # Focus next/previous workspace
  "Mod+Down".action.focus-workspace-down = { };
  "Mod+Left".action.focus-column-left = { };
  "Mod+Up".action.focus-workspace-up = { };
  "Mod+Right".action.focus-column-right = { };

  # # Focus next/previous monitor
  # "Mod+Ctrl+Up".action.focus-monitor-up = { };
  # "Mod+Ctrl+Down".action.focus-monitor-down = { };

  # # Switch to last focused workspace
  # "Alt+Tab".action.focus-workspace-previous = { };

  # ============================================
  # MOVING WINDOWS
  # ============================================

  # Move window to next/previous workspace
  "Mod+Ctrl+Down".action.move-window-to-workspace-down = { };
  "Mod+Ctrl+Left".action.move-column-left = { };
  "Mod+Ctrl+Up".action.move-window-to-workspace-up = { };
  "Mod+Ctrl+Right".action.move-column-right = { };

  # Move workspace
  "Mod+Shift+Down".action.move-workspace-down = { };
  "Mod+Shift+Up".action.move-workspace-up = { };

  # ============================================
  # SCREENSHOTS
  # ============================================

  # Screenshot selected area
  "Mod+S".action.screenshot = [
    { show-pointer = false; }
  ];

  # Screenshot full screen
  "Mod+Shift+S".action.screenshot-screen = [
    { show-pointer = false; }
  ];

  # Screenshot selected window
  "Mod+Ctrl+S".action.screenshot-window = { };

  # ============================================
  # SYSTEM
  # ============================================

  # Lock screen
  "Mod+L".action.spawn = [ "xsecurelock" ];

  # Open clipboard history
  "Mod+V".action.spawn = [
    "sh"
    "-c"
    "cliphist list | rofi -dmenu | cliphist decode | xclip -selection clipboard"
  ];

  # Volume controls
  "XF86AudioRaiseVolume".action.spawn = [
    "wpctl"
    "set-volume"
    "@DEFAULT_AUDIO_SINK@"
    "${volume-step}+"
  ];

  "XF86AudioLowerVolume".action.spawn = [
    "wpctl"
    "set-volume"
    "@DEFAULT_AUDIO_SINK@"
    "${volume-step}-"
  ];

  "XF86AudioMute".action.spawn = [
    "wpctl"
    "set-mute"
    "@DEFAULT_AUDIO_SINK@"
    "toggle"
  ];

  # Brightness controls
  "XF86MonBrightnessUp".action.spawn = [
    "brightnessctl"
    "set"
    "${backlight-step}+"
  ];

  "XF86MonBrightnessDown".action.spawn = [
    "brightnessctl"
    "set"
    "${backlight-step}-"
  ];
}
