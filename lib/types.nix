{lib, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) submodule string;
  mkColorOption = set:
    mkOption {
      type = string;
      # no default... all these need to be set
    };
in rec {
  banner = submodule {
    options = {
      author = mkOption {
        type = string;
        default = "Unknown";
      };
      scheme = mkOption {
        type = string;
        default = "Unknown";
      };
      base00 = mkColorOption {};
      base01 = mkColorOption {};
      base02 = mkColorOption {};
      base03 = mkColorOption {};
      base04 = mkColorOption {};
      base05 = mkColorOption {};
      base06 = mkColorOption {};
      base07 = mkColorOption {};
      base08 = mkColorOption {};
      base09 = mkColorOption {};
      base0A = mkColorOption {};
      base0B = mkColorOption {};
      base0C = mkColorOption {};
      base0D = mkColorOption {};
      base0E = mkColorOption {};
      base0F = mkColorOption {};

      pfg08 = mkColorOption {};
      pfg09 = mkColorOption {};
      pfg0A = mkColorOption {};
      pfg0B = mkColorOption {};
      pfg0C = mkColorOption {};
      pfg0D = mkColorOption {};
      pfg0E = mkColorOption {};
      pfg0F = mkColorOption {};

      highlight = mkColorOption {};
      hialt0 = mkColorOption {};
      hialt1 = mkColorOption {};
      hialt2 = mkColorOption {};

      urgent = mkColorOption {};
      warn = mkColorOption {};
      confirm = mkColorOption {};
      link = mkColorOption {};
    };
  };
}
