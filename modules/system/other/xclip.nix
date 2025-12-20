{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-xclip = config.system.other.xclip;
in
{
  options.system.other.xclip = {
    enable = lib.mkEnableOption "Enable xclip clipboard utility.";
  };

  config = lib.mkIf cfg-xclip.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        xclip
      ];
    };
  };
}
