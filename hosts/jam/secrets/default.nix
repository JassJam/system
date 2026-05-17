{ config, userName, ... }:
{
  # sops configuration
  home-manager.users.${userName} = {
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
    };
  };
}
