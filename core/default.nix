{
  imports = [
    ./hardware-configuration.nix
    ./state-version.nix
    ./nix.nix
    ./boot.nix
    ./services.nix
    ./networking.nix
    ./drivers
    ./programs
  ];
}
