{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-qview = config.system.images.image-viewer.qview;
in
{
  options.system.images.image-viewer.qview = {
    enable = lib.mkEnableOption "Enable qview image viewer";
  };

  config = lib.mkIf cfg-qview.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        qview
      ];
    };
  };
}
