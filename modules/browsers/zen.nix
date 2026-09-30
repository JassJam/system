{
  jutils,
  lib,
  config,
  pkgs,
  inputs,
  fullName,
  userName,
  ...
}:
let
  cfg-zen-browser = config.browsers.zen-browser;

  zen-browser = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system};

  mkExtension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  extensions = [
    (mkExtension "ublock-origin" "uBlock0@raymondhill.net")
    (mkExtension "darkreader" "Dark Reader Ltd")
  ];
in
{
  options.browsers.zen-browser = jutils.mkOptions {
    description = "Enable Zen Browser";
  };

  config = lib.mkIf cfg-zen-browser.enable {
    home-manager.users.${userName} =
      { config, ... }:
      {
        home.packages = [
          (pkgs.wrapFirefox zen-browser.zen-browser-unwrapped {
            extraPrefs = ''
              lockPref("browser.screenshots.dir", "${config.home.homeDirectory}/images/screenshots");
              lockPref("browser.download.dir", "${config.home.homeDirectory}/downloads");
              lockPref("browser.browser.download.folderList", 2); # use custom download directory
              lockPref("browser.download.useDownloadDir", true);

              # Force dark theme for Firefox UI
              lockPref("ui.systemUsesDarkTheme", 1);
              lockPref("widget.content.gtk-theme-override", "catppuccin-mocha-mauve-compact+default");

              lockPref("browser.startup.homepage", "https://searx.rhscz.eu");
              lockPref("browser.search.defaultenginename", "Searx");
              lockPref("browser.search.order.1", "Searx");

              # Default Ctrl-F to highlight all results by default
              lockPref("findbar.highlightAll", true);

              # Allow extensions to be auto-enabled
              lockPref("extensions.autoDisableScopes", 0);
              lockPref("extensions.update.autoUpdateDefault", false);
              lockPref("extensions.update.enabled", false);
              lockPref("extensions.pocket.enabled", false);
            '';

            extraPolicies = {
              DisableTelemetry = true;
              ExtensionSettings = builtins.listToAttrs extensions;
              DownloadDirectory = "${config.home.homeDirectory}/downloads";

              SearchEngines = {
                Default = "ddg";
                Add = [
                  {
                    Name = "nixpkgs packages";
                    URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                    IconURL = "https://wiki.nixos.org/favicon.ico";
                    Alias = "@np";
                  }
                  {
                    Name = "NixOS options";
                    URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                    IconURL = "https://wiki.nixos.org/favicon.ico";
                    Alias = "@no";
                  }
                  {
                    Name = "NixOS Wiki";
                    URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                    IconURL = "https://wiki.nixos.org/favicon.ico";
                    Alias = "@nw";
                  }
                  {
                    Name = "noogle";
                    URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                    IconURL = "https://noogle.dev/favicon.ico";
                    Alias = "@ng";
                  }
                  {
                    Name = "Arch wiki";
                    URLTemplate = "https://wiki.archlinux.org/index.php?search={searchTerms}&title=Special%3ASearch";
                    IconURL = "https://thumb.wikimedia.org/wikipedia/commons/thumb/1/13/Arch_Linux_%22Crystal%22_icon.svg/250px-Arch_Linux_%22Crystal%22_icon.svg.png";
                    Alias = "@aw";
                  }
                  {
                    Name = "Homemanager Nix";
                    URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
                    IconURL = "https://wiki.nixos.org/favicon.ico";
                    Alias = "@hm";
                  }
                ];
              };
            };
          })
        ];
      };
  };
}
