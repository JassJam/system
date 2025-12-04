{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-emscripten = config.coding.langs.emscripten;
in
{
  options.coding.langs.emscripten = {
    enable = lib.mkEnableOption "Install Emscripten SDK for WebAssembly development.";
  };

  config = lib.mkIf cfg-emscripten.enable {
    home.packages = [
      pkgs.emscripten
    ];
  };
}
