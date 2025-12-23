{
  description = "Jass' NixOS Configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    liberodark-flakes = {
      url = "github:liberodark/my-flakes/f6600efd931dcb8b738c28ee4b13b94753cc1a88";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      system = builtins.currentSystem or "x86_64-linux";

      # Helper function to create system configuration
      mkSystem =
        {
          userName,
          hostName,
          fullName,
        }:
        nixpkgs.lib.nixosSystem {
          system = {
            buildPlatform = system;
            hostPlatform = system;
            targetPlatform = system;
          };

          specialArgs = {
            inherit
              inputs
              system
              userName
              hostName
              fullName
              ;
            root = self;
          };

          modules = [
            ./core
            inputs.home-manager.nixosModules.home-manager
            ./modules

            ./hosts/${userName}
          ];
        };
    in
    {
      nixosModules = {
        dotfiles = import ./.;
      }
      // ./modules import;

      nixosConfigurations = {
        jass = mkSystem {
          userName = "jass";
          hostName = "Jam";
          fullName = "Jass";
        };
      };
    };
}
