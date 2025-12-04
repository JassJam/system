{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tuigreet
  ];
}
