{
  lib,
  config,
  pkgs,
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
    home.packages = with pkgs; [
      slack
    ];
  };
}
