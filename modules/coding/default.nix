{
  imports = [
    ./editors/jetbrains.nix
    ./editors/vscode.nix

    ./langs/dotnet.nix
    ./langs/emscripten.nix
    ./langs/java.nix
    ./langs/nodejs.nix
    ./langs/powershell.nix
    ./langs/rust.nix

    ./tools/clang.nix
    ./tools/cmake.nix
    ./tools/direnv.nix
    ./tools/insomnia.nix
    ./tools/mockoon.nix
    ./tools/ninja.nix
    ./tools/valgrind.nix
    ./tools/xmake
  ];
}
