{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-vscode = config.coding.editors.vscode;

  # Custom xmake extension from marketplace
  xmake-vscode = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "xmake-vscode";
      publisher = "tboox";
      version = "2.3.6";
      sha256 = "sha256-mpf3vVC/SVxDapZgljL0OBpnWl5TeC0RN+MDJSh1u/g=";
    };
  };
in
{
  options.coding.editors.vscode = {
    enable = lib.mkEnableOption "Install Visual Studio Code editor with custom configuration.";
  };

  config = lib.mkIf cfg-vscode.enable {
    home-manager.users.${userName} = {
      programs.vscode = {
        enable = true;

        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            # Coding
            ms-vscode.cpptools
            ms-vscode.cpptools-extension-pack
            ms-vscode.cmake-tools
            xmake-vscode
            mesonbuild.mesonbuild

            # Utilities
            brettm12345.nixfmt-vscode
            bbenoist.nix
          ];

          userSettings = {
            # General
            "workbench.colorTheme" = "Catppuccin Mocha";
            "workbench.iconTheme" = "catppuccin-mocha";
            "editor.fontFamily" = "'JetBrains Mono', 'Droid Sans Mono', 'monospace'";
            "editor.fontSize" = 14;
            "editor.lineNumbers" = "on";
            "editor.renderWhitespace" = "boundary";

            # Telemetry
            "telemetry.telemetryLevel" = "off";

            # copilot
            "github.copilot.enable" = {
              "*" = true;
              "plaintext" = false;
              "markdown" = true;
              "scminput" = false;
            };

            "extensions.ignoreRecommendations" = true;
            "diffEditor.ignoreTrimWhitespace" = false;
          };
        };
      };
    };
  };
}
