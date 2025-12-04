{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg-rust = config.coding.langs.rust;

  cfg-rust-enabled = cfg-rust.cargo || cfg-rust.compiler;
in
{
  options.coding.langs.rust = {
    cargo = lib.mkEnableOption "Install Cargo package manager for Rust.";
    compiler = lib.mkEnableOption "Install Rust compiler (rustc).";
  };

  config = lib.mkIf cfg-rust-enabled {
    home.packages =
      lib.optionals cfg-rust.cargo [
        pkgs.cargo
      ]
      ++ lib.optionals cfg-rust.compiler [
        pkgs.rustc
      ];
  };
}
