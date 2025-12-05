{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-fusuma = config.essentials.gestures.fusuma;
in
{
  options.essentials.gestures.fusuma = {
    enable = lib.mkEnableOption "Enable fusuma touchpad gestures";
  };

  config = lib.mkIf cfg-fusuma.enable {
    home.packages = with pkgs; [
      fusuma
      xautomation
    ];

    # Fusuma configuration
    xdg.configFile."fusuma/config.yml".text = ''
      swipe:
        3:
          left:
            command: 'bspc desktop -f next.local'
          right:
            command: 'bspc desktop -f prev.local'
          up:
            command: 'bspc node -t ~fullscreen'
          down:
            command: 'rofi -show drun'

      pinch:
        2:
          in:
            command: 'xte "keydown Control_L" "key plus" "keyup Control_L"'
            threshold: 0.5
          out:
            command: 'xte "keydown Control_L" "key minus" "keyup Control_L"'
            threshold: 0.5

      threshold:
        swipe: 0.5
        pinch: 0.5

      interval:
        swipe: 0.5
        pinch: 0.2
    '';

    # Start fusuma on login
    systemd.user.services.fusuma = {
      Unit = {
        Description = "Fusuma touchpad gesture daemon";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Environment = "PATH=${pkgs.coreutils}/bin:${pkgs.bspwm}/bin:${pkgs.rofi}/bin:${pkgs.xautomation}/bin";
        ExecStart = "${pkgs.fusuma}/bin/fusuma";
        Restart = "on-failure";
        RestartSec = 3;
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
