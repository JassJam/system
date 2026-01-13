{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-clang = config.coding.tools.clang;

  versioned-clang = "clang_${cfg-clang.version}";
  libllvm = "llvmPackages_${cfg-clang.version}";
in
{
  options.coding.tools.clang = {
    enable = lib.mkEnableOption "Install Clang/LLVM compiler for C/C++ development.";
    enable-tools = lib.mkEnableOption "Install Clang tools (clang-tidy, clang-format, etc).";
    enable-libllvm = lib.mkEnableOption "Install LLVM libraries.";
    enable-lldb = lib.mkEnableOption "Install LLDB debugger.";
    version = lib.mkOption {
      type = lib.types.str;
      default = "20";
      description = "Version of Clang/LLVM to install.";
    };
  };

  config = lib.mkIf cfg-clang.enable {
    home-manager.users.${userName}.home = {
      packages = [
        pkgs.${versioned-clang}
      ]
      ++ lib.optionals cfg-clang.enable-tools [
        pkgs.${libllvm}.clang-tools
      ]
      ++ lib.optionals cfg-clang.enable-libllvm [
        pkgs.${libllvm}.libllvm
      ]
      ++ lib.optionals cfg-clang.enable-lldb [
        pkgs.${libllvm}.lldb
      ];
    };
  };
}
