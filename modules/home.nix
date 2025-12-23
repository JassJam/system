{
  inputs,
  system,
  config,
  pkgs,
  userName,
  hostName,
  fullName,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit
        inputs
        system
        userName
        hostName
        fullName
        ;
    };

    users.${userName} = {
      home = {
        username = "${userName}";
        homeDirectory = "/home/${userName}";
        stateVersion = "24.11";
      };

      imports = [
        inputs.catppuccin.homeModules.catppuccin
        inputs.sops-nix.homeManagerModules.sops
        inputs.niri-flake.homeModules.niri
      ];
    };
  };
}
