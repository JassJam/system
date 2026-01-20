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
    toolbox = lib.mkEnableOption "Install JetBrains Toolbox App";
    clion = lib.mkEnableOption "Install JetBrains CLion IDE";
    idea = lib.mkEnableOption "Install JetBrains IDEA OSS Edition";
    webstorm = lib.mkEnableOption "Install JetBrains WebStorm IDE";
  };

  config = {
    home-manager.users.${userName}.home = {
      packages =
        lib.optionals cfg-jetbrains.clion [
          # clion ide for c++
          pkgs.jetbrains.clion
        ]
        ++ lib.optionals cfg-jetbrains.idea [
          # idea OSS edition for java
          pkgs.jetbrains.idea-oss
        ]
        ++ lib.optionals cfg-jetbrains.webstorm [
          # webstorm ide for web development
          pkgs.jetbrains.webstorm
        ]
        ++ lib.optionals cfg-jetbrains.toolbox [
          # jetbrains toolbox app
          pkgs.jetbrains-toolbox
        ];
    };
  };
}
