{lib, ...}: let
  use = path: (import path {inherit lib;});
in
  (use ./math.nix)
  // (use ./util.nix)
  // {distances = use ./distances.nix;}
  // (use ./convert.nix)
