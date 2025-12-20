{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-nixfmt = config.system.other.nixfmt;
in
{
  options.system.other.nixfmt = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable nixfmt formatting tool.";
    };
  };

  config = lib.mkIf cfg-nixfmt.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        nixfmt-rfc-style
      ];
    };
  };
}
