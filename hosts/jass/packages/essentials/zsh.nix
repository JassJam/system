{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-zsh = config.essentials.shell.zsh;
  cfg-catppuccin = config.essentials.theming.catppuccin;

  cfg-yazi = config.essentials.file-manager.yazi;
  init-script-yazi = ''
    # Yazi integration
    function y() {
      local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
      yazi "$@" --cwd-file="$tmp"
      IFS= read -r -d \'\' cwd < "$tmp"
      [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
      rm -f -- "$tmp"
    }
  '';
in
{
  options.essentials.shell.zsh = {
    enable = lib.mkEnableOption "Enable Zsh shell";

    shellAliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        rbld = "nixos-rebuild switch --flake ~/system#${userName} --sudo";

        # Clipboard aliases
        clip = "wl-copy"; # pipe anything to clipboard
        clipp = "wl-paste"; # paste from clipboard
        clipf = "wl-copy <"; # copy file content: clipf file.txt
      };
      description = "Custom shell aliases to add to Zsh.";
    };

    initContent = lib.mkOption {
      type = lib.types.str;
      default = ''
        # Bind Ctrl+Right to forward-word
        bindkey ";5C" forward-word

        # Bind Ctrl+Left to backward-word  
        bindkey ";5D" backward-word
      '';
      description = "Custom initialization content for Zsh.";
    };
  };

  config = lib.mkIf cfg-zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh.enable = true;

      shellAliases = cfg-zsh.shellAliases;

      initContent = ''
        ${cfg-zsh.initContent}
        ${if cfg-yazi.enable then init-script-yazi else ""}
      '';
    };

    catppuccin.zsh-syntax-highlighting = cfg-catppuccin;
  };
}
