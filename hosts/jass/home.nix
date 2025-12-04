{
  inputs,
  config,
  pkgs,
  userName,
  hostName,
  fullName,
  ...
}:
{
  home = {
    username = userName;
    homeDirectory = "/home/${userName}";
    stateVersion = "24.11";
  };

  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ./secrets
    ./configs
    ./services.nix
    ./fonts.nix
    ./packages/hm-packages.nix
  ];
}
