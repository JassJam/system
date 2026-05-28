{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-godot = config.fun.other.godot;
in
{
  options.fun.other.godot = {
    enable = lib.mkEnableOption "Enable godot-mono";
  };

  config = lib.mkIf cfg-godot.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        godot-mono
      ];
    };
  };
}
