{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg-asus = config.system.drivers.asus;
in
{
  options.system.drivers.asus = {
    enable = lib.mkEnableOption "Enable ASUS support (asusctl, asusd, etc.)";
  };

  config = lib.mkIf cfg-asus.enable {
    # Enable asusd daemon
    services.asusd = {
      enable = true;
      enableUserService = true;
    };

    # Enable supergfxd daemon for gpu switching
    services.supergfxd = {
      enable = true;
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

    services.hardware.openrgb.enable = true;

    environment.systemPackages = with pkgs; [
      asusctl
      openrgb
      openrgb-with-all-plugins
      (pkgs.writeShellScriptBin "asus-perf-toggle" (builtins.readFile ./asus-perf-toggle.sh))
    ];
  };
}
