{ pkgs, ... }:
[
  # block out notifications from screencast
  {
    matches = [
      { namespace = "^notifications$"; }
    ];
    block-out-from = "screencast";
  }
]
