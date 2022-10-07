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
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    genSystems = nixpkgs.lib.genAttrs supportedSystems;
    pkgSets = genSystems (system: import nixpkgs {inherit system;});
  in {
    # packages = genSystems (system: let
    #   pkgs = pkgSets.system;
    # in {
    # });
    lib = import ./lib {inherit (nixpkgs) lib;};
  };
}
