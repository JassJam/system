{
  lib,
  config,
  pkgs,
  inputs,
  userName,
  fullName,
  ...
}:
let
  cfg-firefox = config.browsers.firefox;

  firefox-addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  options.browsers.firefox = {
    enable = lib.mkEnableOption "Enable Firefox Browser";
  };

  config = lib.mkIf cfg-firefox.enable {
    programs.firefox = {
      enable = true;

      policies = {
        DefaultDownloadDirectory = "${config.home.homeDirectory}/downloads";
        DisableAppUpdate = true;
        DisableTelemetry = true;
        Homepage = {
          StartPage = "previous-session";
        };
      };

      profiles = {
        ${userName} = {
          id = 0;
          name = fullName;
          isDefault = true;

          settings = {
            "browser.download.dir" = "${config.home.homeDirectory}/downloads";
            "browser.download.folderList" = 2; # use custom download directory
            "browser.download.useDownloadDir" = true;

            # Force dark theme for Firefox UI
            "ui.systemUsesDarkTheme" = 1;
            "widget.content.gtk-theme-override" = "catppuccin-mocha-mauve-compact+default";

            "browser.startup.homepage" = "https://searx.rhscz.eu";
            "browser.search.defaultenginename" = "Searx";
            "browser.search.order.1" = "Searx";

            # Default Ctrl-F to highlight all results by default
            "findbar.highlightAll" = true;

            # Allow extensions to be auto-enabled
            "extensions.autoDisableScopes" = 0;
            "extensions.update.autoUpdateDefault" = false;
            "extensions.update.enabled" = false;
          };
          search = {
            force = true;
            default = "searx";
            order = [
              "searx"
              "google"
            ];
            engines = {
              "nix packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              "nixos homemanager" = {
                urls = [
                  { template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master"; }
                ];
                icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@hm" ];
              };
              "nixos wiki" = {
                urls = [ { template = "https://nixos.wiki/index.php?search={searchTerms}"; } ];
                icon = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [ "@nw" ];
              };
              "searx" = {
                urls = [ { template = "https://searx.aicampground.com/?q={searchTerms}"; } ];
                icon = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [ "@s" ];
              };
              "bing".metaData.hidden = true;
              "google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
              "youtube" = {
                urls = [ { template = "https://www.youtube.com/results?search_query={searchTerms}"; } ];
                icon = "https://www.youtube.com/s/desktop/6b6f6f5c/img/favicon_144x144.png";
                definedAliases = [ "@yt" ];
              };
            };
          };

          extensions = {
            force = true;
            packages = with firefox-addons; [
              ublock-origin
              darkreader
            ];
          };
        };
      };
    };
  };
}
