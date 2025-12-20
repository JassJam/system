{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-prismlauncher = config.fun.gaming.prismlauncher;
in
{
  options.fun.gaming.prismlauncher = {
    enable = lib.mkEnableOption "Prism Launcher for Minecraft modpacks.";
  };

  config = lib.mkIf cfg-prismlauncher.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        prismlauncher
      ];
    };
  };
}
