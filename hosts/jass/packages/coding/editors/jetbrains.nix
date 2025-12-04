{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-jetbrains = config.coding.editors.jetbrains;
in
{
  options.coding.editors.jetbrains = {
    clion = lib.mkEnableOption "Install JetBrains CLion IDE";
    idea-community = lib.mkEnableOption "Install JetBrains IDEA Community Edition";
  };

  config = {
    home.packages =
      lib.optionals cfg-jetbrains.clion [
        # clion ide for c++
        pkgs.jetbrains.clion
      ]
      ++ lib.optionals cfg-jetbrains.idea-community [
        # idea community edition for java
        pkgs.jetbrains.idea-community
      ];
  };
}
