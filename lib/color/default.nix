{lib, ...}: let
  use = path: (import path {inherit lib;});
in
  (use ./math)
  // (use ./util)
  // {distances = use ./distances.nix;}
  // (use ./convert.nix)
