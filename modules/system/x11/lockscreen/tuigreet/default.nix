{
  lib,
  pkgs,
  config,
  userName,
  ...
}:
let
  cfg-tuigreet = config.system.x11.lockscreen.tuigreet;
in
{
  options.system.x11.lockscreen.tuigreet = {
    enable = lib.mkEnableOption "Enable tuigreet login greeter.";
  };

  config = lib.mkIf cfg-tuigreet.enable {
    environment.systemPackages = with pkgs; [
      tuigreet
    ];

    services = {
      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.bash}/bin/bash -c 'clear && ${pkgs.tuigreet}/bin/tuigreet --time --cmd startx'";
            user = "greeter";
          };
        };
      };
    };
  };
}
