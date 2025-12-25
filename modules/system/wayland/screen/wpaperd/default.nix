{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-wpaperd = config.system.wayland.screen.wpaperd;
  tomlFormat = pkgs.formats.toml { };
in
{
  options.system.wayland.screen.wpaperd = {
    enable = lib.mkEnableOption "Enable wpaperd for Wayland wallpapers.";
    settings = lib.mkOption {
      type = tomlFormat.type;
      description = "Settings for wpaperd per output.";
      default = { };
    };
  };

  config = lib.mkIf cfg-wpaperd.enable {
    home-manager.users.${userName} = {
      services.wpaperd = {
        enable = true;
        settings = cfg-wpaperd.settings;
      };
    };
  };
}
