{
  jutils,
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-vscodium = config.coding.editors.vscodium;
in
{
  options.coding.editors.vscodium = jutils.mkOptions {
    description = "Install VS Codium editor with custom configuration.";
  };

  config = lib.mkIf cfg-vscodium.enable {
    home-manager.users.${userName} = {
      programs.vscodium = {
        enable = true;

        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
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
      }
      // cfg-vscodium.options;
    };
  };
}
