{ pkgs, config, userName, fullName, ... }:
{
  users.users.${userName} = {
    isNormalUser = true;
    description = fullName;
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "scanner"
      "lp"
      "video"
      "input"
      "audio"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
}
