{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-gajim = config.chat.gajim;
in
{
  options.chat.gajim = {
    enable = lib.mkEnableOption "Gajim instant messenger";
  };

  config = lib.mkIf cfg-gajim.enable {
    home.packages = with pkgs; [
      gajim
    ];
  };
}
