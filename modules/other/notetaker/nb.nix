{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-nb = config.other.notetaker.nb;
in
{
  options.other.notetaker.nb = {
    enable = lib.mkEnableOption "A terminal-based note-taking application";
  };

  config = lib.mkIf cfg-nb.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        nb
      ];
    };
  };
}
