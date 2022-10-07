{lib, ...}: {
  color = import ./color {inherit lib;};
  parsers = import ./parsers.nix {inherit lib;};
}
