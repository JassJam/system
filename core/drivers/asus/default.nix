{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg-asus = config.drivers.asus;
in
{
  options.drivers.asus = {
    enable = lib.mkEnableOption "Enable ASUS support (asusctl, asusd, etc.)";
  };

  config = lib.mkIf cfg-asus.enable {
    # Enable asusd daemon
    services.asusd = {
      enable = true;
      enableUserService = true;
    };

    systemd.services.asus-power-profile = {
      description = "Set ASUS power profile to battery-friendly on boot";
      after = [ "asusd.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.asusctl}/bin/asusctl profile -P Quiet";
      };
    };

    environment.systemPackages = with pkgs; [
      asusctl
      (pkgs.writeShellScriptBin "asus-perf-toggle" (builtins.readFile ./asus-perf-toggle.sh))
    ];

    services.xserver.videoDrivers = [
      "amdgpu"
    ];
  };
}
