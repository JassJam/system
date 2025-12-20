{
  imports = [
    # secrets encryption with sops
    ./sops.nix

    # password management
    ./password-store.nix
    ./gpg.nix

    # ssh management
    ./ssh.nix

    # git
    ./git.nix
  ];
}
