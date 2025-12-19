{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg-amd = config.drivers.amd;
in
{
  options.drivers.amd = {
    enable = lib.mkEnableOption "Enable AMD GPU support (amdgpu driver, etc.)";
  };

  config = lib.mkIf cfg-amd.enable {
    services.xserver.videoDrivers = [
      "amdgpu"
    ];

    hardware.amdgpu.overdrive.ppfeaturemask = "0xffffffff";
  };
}
