{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-java = config.coding.langs.java;
in
{
  options.coding.langs.java = {
    enable = lib.mkEnableOption "Install Java Development Kit (JDK) for Java programming.";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.jdk21_headless;
      description = "The Java Development Kit (JDK) package to install.";
    };
  };

  config = lib.mkIf cfg-java.enable {
    programs.java = {
      enable = true;
      package = cfg-java.package;
    };
  };
}
