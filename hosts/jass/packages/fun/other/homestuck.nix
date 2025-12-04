{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-homestuck = config.fun.other.homestuck;
in
{
  options.fun.other.homestuck = {
    enable = lib.mkEnableOption "Unoffical Homestuck comics viewer.";
  };

  config = lib.mkIf cfg-homestuck.enable {
    home.packages = with pkgs; [
      unofficial-homestuck-collection
    ];
  };
}
