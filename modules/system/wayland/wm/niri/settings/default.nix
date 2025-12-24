{
  lib,
  config,
  pkgs,
  inputs,
  fullName,
  userName,
  system,
  ...
}:
let
  home-directory = config.home.homeDirectory;
in
{
  screenshot-path = "${home-directory}/images/screenshots/%Y-%m-%d_%H-%M-%S.png";

  binds = import ./bindings.nix {
    inherit
      lib
      config
      pkgs
      inputs
      fullName
      userName
      system
      ;
  };

  window-rules = import ./window-rules.nix {
    inherit
      lib
      config
      pkgs
      inputs
      fullName
      userName
      system
      ;
  };

  layer-rules = import ./layer-rules.nix {
    inherit
      lib
      config
      pkgs
      inputs
      fullName
      userName
      system
      ;
  };

  outputs = import ./display.nix {
    inherit
      lib
      config
      pkgs
      inputs
      fullName
      userName
      system
      ;
  };
}
