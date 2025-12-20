{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-gitui = config.essentials.file-manager.gitgui;
in
{
  options.essentials.file-manager.gitgui = {
    enable = lib.mkEnableOption "Enable gitui TUI for git.";
  };

  config = lib.mkIf cfg-gitui.enable {
    home-manager.users.${userName} = {
      programs.gitui.enable = true;
    };
  };
}
