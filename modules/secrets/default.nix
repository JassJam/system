{
  imports = [
    # password management
    ./password-store.nix
    ./gpg.nix

    # ssh management
    ./ssh.nix

    # git
    ./git.nix

    # vpn services
    ./openfortivpn.nix
  ];
}
