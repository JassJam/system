{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-nodejs = config.coding.langs.nodejs;
in
{
  options.coding.langs.nodejs = {
    enable = lib.mkEnableOption "Install Node.js runtime for JavaScript development.";
  };

  config = lib.mkIf cfg-nodejs.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        nodejs
      ];
    };
  };
}
