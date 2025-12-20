{ pkgs, userName, ... }:
let
  wiki-tui-custom = pkgs.rustPlatform.buildRustPackage rec {
    pname = "wiki-tui";
    version = "0.9.2";

    src = pkgs.fetchFromGitHub {
      owner = "Builditluc";
      repo = "wiki-tui";
      rev = "ff41c522ae89627ea4ba7e0d630ea7cae9d3374b";
      sha256 = "sha256-hUAe2mzz/4xdpyPE2rbTq5WKk0bNa4dSFocFiCXyO4Q=";
    };

    cargoHash = "sha256-0M3vHj/dzHcI2FJLramTsFMw4m/WGp9vX9Tq52dSW1o=";

    nativeBuildInputs = with pkgs; [
      pkg-config
    ];

    buildInputs = with pkgs; [
      openssl
    ];

    meta = with pkgs.lib; {
      description = "A simple and easy to use Wikipedia Text User Interface";
      homepage = "https://github.com/Builditluc/wiki-tui";
      license = licenses.mit;
      maintainers = [
        "Builditluc"
      ];
    };
  };

  cfg-wiki-tui = config.fun.other.wiki-tui;
in
{
  options.fun.other.wiki-tui = {
    enable = pkgs.lib.mkEnableOption "A simple and easy to use Wikipedia Text User Interface.";
    default = false;
  };

  config = pkgs.lib.mkIf cfg-wiki-tui.enable {
    home-manager.users.${userName}.home = {
      packages = with pkgs; [
        wiki-tui-custom
      ];
    };
  };
}
