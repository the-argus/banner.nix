{
  pkgs,
  config,
  lib,
  ...
}: let
  bannerlib = import ../../lib {inherit lib;};
in {
  sway = import ./sway bannerlib;
}
