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
      "render"
      "input"
      "audio"
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
}
