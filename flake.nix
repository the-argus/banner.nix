{
  description = ''
    Nix builders for color palettes for home-manager modules according
    to banner specifications.
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-22.05";
  };

  outputs = {
    self,
    nixpkgs,
  }: rec {
    lib = import ./lib {inherit (nixpkgs) lib;};

    module = let
      bannerLib = lib;
    in
      {pkgs, ...}: {
        options.banner.palette = pkgs.lib.mkOption {
          type = bannerLib.types.banner;
          description = ''
            A color palette in the banner format.
          '';
        };
      };
  };
}
