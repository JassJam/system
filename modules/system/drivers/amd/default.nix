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

    hardware.amdgpu.overdrive.ppfeaturemask = "0xffffffff";
  };
}
