{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg-nvidia = config.drivers.nvidia;
in
{
  options.drivers.nvidia = {
    enable = lib.mkEnableOption "Enable Nvidia Drivers";
  };

  config = lib.mkIf cfg-nvidia.enable {
    # Allow unfree and broken packages for NVIDIA
    nixpkgs.config.allowBroken = true;

    services.xserver.videoDrivers = [
      "nvidia"
    ];

    hardware.graphics = {
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva-vdpau-driver
        libvdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
        vdpauinfo
        libva
        libva-utils
      ];
    };

    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management.
      powerManagement.enable = true;

      # Fine-grained power management. Keep disabled for gaming performance
      powerManagement.finegrained = false;

      nvidiaPersistenced = true;

      # Use the NVidia open source kernel module
      open = true;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
