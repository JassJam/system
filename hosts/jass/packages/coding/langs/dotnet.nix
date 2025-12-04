{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-dotnet = config.coding.langs.dotnet;

  dotnet-has-sdk = cfg-dotnet.sdk != "";
  dotnet-has-runtime = cfg-dotnet.runtime != "";

  dotnet-sdk-version = "dotnet-sdk_" + cfg-dotnet.sdk;
  dotnet-runtime-version = "dotnet-runtime_" + cfg-dotnet.runtime;
in
{
  options.coding.langs.dotnet = {
    enable = lib.mkEnableOption "Install .NET SDK and runtime.";
    runtime = lib.mkOption {
      type = lib.types.str;
      default = "9";
      description = "Specify the .NET runtime version to install.";
    };
    sdk = lib.mkOption {
      type = lib.types.str;
      default = "9";
      description = "Specify the .NET SDK version to install.";
    };
  };

  config = lib.mkIf cfg-dotnet.enable {
    home.packages =
      lib.optionals dotnet-has-sdk [
        pkgs."${dotnet-sdk-version}"
      ]
      ++ lib.optionals dotnet-has-runtime [
        pkgs."${dotnet-runtime-version}"
      ];
  };
}
