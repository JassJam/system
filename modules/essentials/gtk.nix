{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-gtk = config.essentials.theming.gtk;
in
{
  options.essentials.theming.gtk = {
    enable = lib.mkEnableOption "Enable GTK theming";

    theme = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Adwaita-dark";
        description = "GTK theme name";
      };

      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.gnome-themes-extra;
        description = "GTK theme package";
      };
    };

    iconTheme = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Adwaita";
        description = "GTK icon theme name";
      };

      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.adwaita-icon-theme;
        description = "GTK icon theme package";
      };
    };

    colorScheme = lib.mkOption {
      type = lib.types.enum [
        "default"
        "prefer-dark"
        "prefer-light"
        "dark"
        "light"
      ];
      default = "prefer-dark";
      description = "GTK color scheme preference";
    };
  };

  config = lib.mkIf cfg-gtk.enable {
    programs.dconf.enable = true;

    home-manager.users.${userName} = {
      gtk = {
        enable = true;
        # theme = {
        #   name = lib.mkForce cfg-gtk.theme.name;
        #   package = lib.mkForce cfg-gtk.theme.package;
        # };
        # iconTheme = {
        #   name = lib.mkDefault cfg-gtk.iconTheme.name;
        #   package = lib.mkDefault cfg-gtk.iconTheme.package;
        # };

        gtk3 = {
          extraConfig = {
            gtk-application-prefer-dark-theme = 1;
          };
        };

        gtk4 = {
          extraConfig = {
            gtk-application-prefer-dark-theme = 1;
          };
        };
      };

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = cfg-gtk.colorScheme;
          # gtk-theme = cfg-gtk.theme.name;
        };
      };

      home.sessionVariables = {
        ADW_DISABLE_PORTAL = "1";
      };
    };
  };
}
