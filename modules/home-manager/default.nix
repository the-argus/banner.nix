{
  pkgs,
  config,
  lib,
  ...
}: let
  bannerlib = import ../../lib {inherit lib;};
in {
  gnome = import ./gnome bannerlib;
}
