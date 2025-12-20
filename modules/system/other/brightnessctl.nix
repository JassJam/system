{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-brightnessctl = config.system.other.brightnessctl;
in
{
  options.system.other.brightnessctl = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable brightnessctl utility.";
    };
  };

  config = lib.mkIf cfg-brightnessctl.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        brightnessctl
      ];
    };
  };
}
