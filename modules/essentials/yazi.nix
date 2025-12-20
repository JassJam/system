{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-yazi = config.essentials.file-manager.yazi;
  cfg-zsh = config.essentials.shell.zsh;
in
{
  options.essentials.file-manager.yazi = {
    enable = lib.mkEnableOption "Enable yazi file manager";
    gitgui = lib.mkEnableOption "Enable gitui integration for yazi.";
  };

  config = lib.mkIf cfg-yazi.enable {
    home-manager.users.${userName} = {
      programs.yazi = {
        enable = true;
        enableZshIntegration = cfg-zsh.enable;

        settings = {
          font = {
            family = "JetBrainsMono Nerd Font";
            size = 12;
          };

          mgr = {
            show_hidden = true;
            show_symlink = true;
          };

          preview = {
            enable = true;
            max_size_bytes = 10485760; # 10 MB
          };

          tasks = {
            image_bound = [
              10000
              10000
            ];
          };
        }
        // lib.optionalAttrs (cfg-yazi.gitgui) {
          keymap = {
            manager.prepend_keymap = [
              {
                on = [
                  "g"
                  "i"
                ];
                run = "plugin gitui";
                desc = "run gitui";
              }
            ];
          };
        };
      };

      home.packages =
        with pkgs;
        lib.mkIf cfg-yazi.gitgui [
          yaziPlugins.gitui
        ];
    };
  };
}
