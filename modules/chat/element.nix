{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-element = config.chat.element;
in
{
  options.chat.element = {
    enable = lib.mkEnableOption "element MATRIX client";
  };

  config = lib.mkIf cfg-element.enable {
    home-manager.users.${userName} = {
      programs.element-desktop = {
        enable = true;
      };
    };
  };
}
