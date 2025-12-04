{ options, hostName, ... }:
{
  networking = {
    networkmanager.enable = true;
    hostName = hostName;
    timeServers = options.networking.timeServers.default ++ [
      "pool.ntp.org"
    ];

    # firewall = {
    #   enable = true;
    #   allowedTCPPorts = [ 22 80 443 ];
    #   allowedUDPPorts = [ 53 ];
    # };
  };
}
