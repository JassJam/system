{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.system.drivers.intel;
in
{
  options.system.drivers.intel = {
    enable = lib.mkEnableOption "Enable Intel Graphics Drivers";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {
        enableHybridCodec = true;
      };
    };

    # OpenGL
    hardware.graphics = {
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
        libva
        libva-utils
      ];
    };
  };
}
