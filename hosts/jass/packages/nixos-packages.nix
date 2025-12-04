{ pkgs, ... }:
{
  imports = [
    # steam
    ./fun/gaming/steam.nix
  ];

  fun = {
    gaming = {
      steam.enable = true;
    };
  };
}
