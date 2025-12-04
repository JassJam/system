{ inputs, ... }:
{
  imports = [
    ./user.nix
    ./virtualisation.nix
    ./timezone.nix

    inputs.catppuccin.nixosModules.catppuccin
  ];

  drivers = {
    asus.enable = true;
    nvidia = {
      enable = true;
      prime = {
        enable = true;
        amdBusID = "PCI:5:0:0";
        nvidiaBusID = "PCI:1:0:0";
      };
    };
  };
}
