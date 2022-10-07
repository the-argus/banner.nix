{lib, ...}: {
  color = import ./color {inherit lib;};
  parsers = import ./parsers.nix {inherit lib;};
  types = import ./types.nix {inherit lib;};
}
