{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-nautilus = config.essentials.file-manager.nautilus;
in
{
  options.essentials.file-manager.nautilus = {
    enable = lib.mkEnableOption "Enable GNOME Nautilus file manager for file picker dialogs";
    default = lib.mkEnableOption "Set Nautilus as the default file manager for xdg-open";
  };

  config = lib.mkIf cfg-nautilus.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        nautilus
      ];
    };

    # Set nautilus as the default file manager for xdg-open
    xdg.mime.defaultApplications = lib.mkIf cfg-nautilus.default {
      "inode/directory" = [ "nautilus.desktop" ];
    };
  };
}
