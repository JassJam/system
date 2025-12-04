{ config, ... }:
{
  # sops configuration
  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    
    secrets = {
      "ssh/music_server/hostname" = {};
      "ssh/music_server/user" = {};

      "github/username" = {};
      "github/email" = {};
    };
  };
}
