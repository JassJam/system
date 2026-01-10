{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg-amd = config.system.drivers.amd;
in
{
  options.system.drivers.amd = {
    enable = lib.mkEnableOption "Enable AMD GPU support (amdgpu driver, etc.)";
  };

  config = lib.mkIf cfg-amd.enable {
    services.xserver.videoDrivers = [
      "amdgpu"
    ];

    hardware.amdgpu.overdrive.ppfeaturemask = "0xfffd7fff";

    boot.kernelParams = [
      # Disable aggressive GFX_DPM power feature that causes GPU hangs
      # 0xfffd7fff = all features except bit 15 (GFX_DPM)
      "amdgpu.ppfeaturemask=0xfffd7fff"
      # Enable GPU recovery when hangs occur
      "amdgpu.gpu_recovery=1"
      # Enable Display Core
      "amdgpu.dc=1"
      # Disable PSR (Panel Self Refresh) - causes display freezes on laptops
      "amdgpu.dcdebugmask=0x10"
    ];
  };
}
