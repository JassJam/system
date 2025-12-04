{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-cliphist = config.essentials.cliphist;
in
{
  options.essentials.cliphist = {
    enable = lib.mkEnableOption "Enable cliphist clipboard manager";
  };

  config = lib.mkIf cfg-cliphist.enable {
    home.packages = with pkgs; [
      clipnotify
    ];

    services.cliphist = {
      enable = true;
      allowImages = true;
      clipboardPackage = pkgs.xclip;
    };

    systemd.user.services.cliphist-clipboard = {
      Unit = {
        Description = "X11 based clipboard events listener";
      };
      Service = {
        ExecStart = ''
          ${pkgs.bash}/bin/bash -c 'while ${pkgs.clipnotify}/bin/clipnotify; do ${pkgs.xclip}/bin/xclip -o -selection c | ${pkgs.cliphist}/bin/cliphist store; done'
        '';
        Restart = "always";
        TimeoutSec = 3;
        RestartSec = 3;
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
