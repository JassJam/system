{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-screen = config.system.screen;
in
{
  options.system.screen = {
    sxhkd = {
      enable = lib.mkEnableOption "Enable sxhkd hotkey daemon.";
    };
  };

  config = lib.mkIf cfg-screen.sxhkd.enable {
    home.packages = with pkgs; [
      sxhkd
    ];
  };
}
