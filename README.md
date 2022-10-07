# Stylix

Set one config attr, ``stylix.bannerPalette``, and then just import modules
supplied by this flake and find your programs all fit this palette.
Don't like what you see? Use color templates or overrides to fix how certain
palettes apply.

Converts [banner](https://github.com/the-argus/banner) color palettes written
in yaml into nix attrsets. The banner palette format is designed to make sure
that any palette which follows its specifications will look good (or at least
be readable) in every context.

A "fork" of [Stylix](https://github.com/danth/stylix), which uses base16
palettes, a simpler version of banner. Template support to come as well.
