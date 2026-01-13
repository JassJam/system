{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let  
  cfg-xmake = config.coding.tools.xmake;
in
{
  options.coding.tools.xmake = {
    enable = lib.mkEnableOption "Install XMake build utility.";
    version = lib.mkOption {
      type = lib.types.str;
      default = "3.0.6";
      description = "Version of XMake to install.";
    };
    hash = lib.mkOption {
      type = lib.types.str;
      default = pkgs.lib.fakeHash;
      description = "Hash of the XMake source for verification.";
    }; 
  };

  config = lib.mkIf cfg-xmake.enable {
    home-manager.users.${userName}.home = {
      packages = [
        (pkgs.callPackage ./package.nix {
          version = cfg-xmake.version;
          hash = cfg-xmake.hash;
        })
      ];
    };
  };
}
