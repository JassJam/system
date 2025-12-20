{
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
  options.secrets.vcs.git = {
    enable = lib.mkEnableOption "Git version control system";

    use-secrets = lib.mkEnableOption "Use username and email from sops secrets";

    default-username = lib.mkOption {
      type = lib.types.str;
      default = fullName;
      description = "Default git username when not using secrets";
    };

    default-email = lib.mkOption {
      type = lib.types.str;
      default = "email@placeholder.com";
      description = "Default git email when not using secrets";
    };
  };

  config = lib.mkIf cfg-git.enable {
    home-manager.users.${userName} =
      { config, ... }:
      {
        sops.templates."gitconfig-user" = lib.mkIf cfg-git.use-secrets {
          content = ''
            [user]
              name = ${config.sops.placeholder."github/username"}
              email = ${config.sops.placeholder."github/email"}
          '';
        };

        programs.git = {
          enable = true;

          includes =
            lib.optionals cfg-git.use-secrets [
              {
                path = config.sops.templates."gitconfig-user".path;
              }
            ]
            ++ [
              {
                path = "~/projects/.gitconfig";
                condition = "gitdir:~/projects/";
              }
              {
                path = "~/work/.gitconfig";
                condition = "gitdir:~/work/";
              }
            ];

          settings = lib.mkIf (!cfg-git.use-secrets) {
            user = {
              name = cfg-git.default-username;
              email = cfg-git.default-email;
            };

            url."ssh://git@codeberg.org/".insteadOf = "https://codeberg.org/";
            url."ssh://git@github.com/".insteadOf = "https://github.com/";
          };
        };
      };
  };
}
