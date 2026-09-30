{ lib, ... }:
{
  mkOptions =
    {
      description,
      defaultEnabled ? false,
      defaultOptions ? { },
    }:
    {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = defaultEnabled;
        description = description;
      };

      options = lib.mkOption {
        type = lib.types.submodule {
          freeformType = lib.types.attrsOf lib.types.anything;
        };
        default = defaultOptions;
        description = "";
      };
    };
}
