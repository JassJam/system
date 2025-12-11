{ pkgs, ... }:
{
  hardware = {
    enableRedistributableFirmware = true;
    enableAllFirmware = true;

    firmware = with pkgs; [
      linux-firmware
    ];
  };
}
