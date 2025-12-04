{ inputs, system, userName, hostName, fullName, ... }:
{
  imports = [
    ./nixos
    ./packages/nixos-packages.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs system userName hostName fullName; };
    users.${userName} = import ./home.nix;
  };
}
