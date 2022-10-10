{lib, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) submodule str;
  mkColorOption = set:
    mkOption {
      type = str;
      # no default... all these need to be set
    };
in rec {
  banner = submodule {
    options = {
      author = mkOption {
        type = str;
        default = "Unknown";
      };
      scheme = mkOption {
        type = str;
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

      highlight = mkColorOption {};
      hialt0 = mkColorOption {};
      hialt1 = mkColorOption {};
      hialt2 = mkColorOption {};
      urgent = mkColorOption {};
      warn = mkColorOption {};
      confirm = mkColorOption {};
      link = mkColorOption {};

      pfg-highlight = mkColorOption {};
      pfg-hialt0 = mkColorOption {};
      pfg-hialt1 = mkColorOption {};
      pfg-hialt2 = mkColorOption {};
      pfg-urgent = mkColorOption {};
      pfg-warn = mkColorOption {};
      pfg-confirm = mkColorOption {};
      pfg-link = mkColorOption {};

      ansi00 = mkColorOption {};
      ansi01 = mkColorOption {};
      ansi02 = mkColorOption {};
      ansi03 = mkColorOption {};
      ansi04 = mkColorOption {};
      ansi05 = mkColorOption {};
      ansi06 = mkColorOption {};
      ansi07 = mkColorOption {};
    };
  };
}
