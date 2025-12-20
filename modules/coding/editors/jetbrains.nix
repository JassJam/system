{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-jetbrains = config.coding.editors.jetbrains;
in
{
  options.coding.editors.jetbrains = {
    clion = lib.mkEnableOption "Install JetBrains CLion IDE";
    idea-community = lib.mkEnableOption "Install JetBrains IDEA Community Edition";
    webstorm = lib.mkEnableOption "Install JetBrains WebStorm IDE";
  };

  config = {
    home-manager.users.${userName}.home = {
      packages =
        lib.optionals cfg-jetbrains.clion [
          # clion ide for c++
          pkgs.jetbrains.clion
        ]
        ++ lib.optionals cfg-jetbrains.idea-community [
          # idea community edition for java
          pkgs.jetbrains.idea-community
        ]
        ++ lib.optionals cfg-jetbrains.webstorm [
          # webstorm ide for web development
          pkgs.jetbrains.webstorm
        ];
    };
  };
}
