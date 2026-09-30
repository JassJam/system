{
  jutils,
  lib,
  config,
  pkgs,
  fullName,
  userName,
  ...
}:
let
  cfg-git = config.secrets.vcs.git;

  git-app = pkgs.git;
in
{
  options.secrets.vcs.git = jutils.mkOptions {
    description = "Git version control system.";
  };

  config = lib.mkIf cfg-git.enable {
    home-manager.users.${userName} =
      { config, ... }:
      {
        programs.git = {
          enable = true;

          includes = [
            {
              path = "~/.gitconfig";
              condition = "gitdir:~/";
            }
          ];
        }
        // cfg-git.options;
      };
  };
}
