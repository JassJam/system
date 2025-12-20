{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-slack = config.chat.slack;
in
{
  options.chat.slack = {
    enable = lib.mkEnableOption "Slack desktop client";
  };

  config = lib.mkIf cfg-slack.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        slack
      ];
    };
  };
}
