{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg-nvidia = config.system.drivers.nvidia;
  cfg-nvidia-prime = config.system.drivers.nvidia.prime;
in
{
  options.system.drivers.nvidia.prime = {
    enable = lib.mkEnableOption "Enable Nvidia Prime Hybrid GPU Offload";

    sync = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Nvidia Prime Hybrid GPU Sync Mode (rendering is completely delegated to the dGPU)";
    };

    intelBusID = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
    };

    nvidiaBusID = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
    };

    amdBusID = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
  };

  config = lib.mkIf (cfg-nvidia.enable && cfg-nvidia-prime.enable) {
    hardware.nvidia = {
      prime = {
        sync.enable = cfg-nvidia-prime.sync;

        offload = {
          enable = !cfg-nvidia-prime.sync;
          enableOffloadCmd = !cfg-nvidia-prime.sync;
        };

        nvidiaBusId = cfg-nvidia-prime.nvidiaBusID;
        # set amdgpuBusId if its not null
        amdgpuBusId = lib.optionalString (cfg-nvidia-prime.amdBusID != null) cfg-nvidia-prime.amdBusID;
        intelBusId = lib.optionalString (cfg-nvidia-prime.intelBusID != null) cfg-nvidia-prime.intelBusID;
      };
    };
  };
}
