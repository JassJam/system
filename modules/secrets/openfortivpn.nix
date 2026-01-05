{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-openfortivpn = config.secrets.openfortivpn;
in
{
  options.secrets.openfortivpn = {
    enable = lib.mkEnableOption "Client for PPP+SSL VPN tunnel services";
  };

  config = lib.mkIf cfg-openfortivpn.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        openfortivpn
      ];
    };
  };
}
