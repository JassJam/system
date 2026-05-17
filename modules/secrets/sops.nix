{ config, userName, ... }:
{
  # sops configuration
  home-manager.users.${userName} =
    { config, ... }:
    {
      sops = {
        age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

        secrets = {
          "ssh/n-server/hostname" = { };
          "ssh/n-server/user" = { };

          "git/username" = { };
          "git/email" = { };
        };
      };
    };
}
