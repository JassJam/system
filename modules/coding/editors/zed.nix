{
  jutils,
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-zed = config.coding.editors.zed;
in
{
  options.coding.editors.zed = jutils.mkOptions {
    description = "Install VS Codium editor with custom configuration.";
  };

  config = lib.mkIf cfg-zed.enable {
    home-manager.users.${userName} = {
      programs.zed-editor = {
        enable = true;

        extensions = [
            "nix"
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
      }
      // cfg-zed.options;
    };
  };
}
