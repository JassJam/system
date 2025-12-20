{ config, userName, ... }:
{
  # sops configuration
  home-manager.users.${userName} =
    { config, ... }:
    {
      sops = {
        age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

        secrets = {
          "ssh/music_server/hostname" = { };
          "ssh/music_server/user" = { };

          "github/username" = { };
          "github/email" = { };
        };
      };
    };
}
