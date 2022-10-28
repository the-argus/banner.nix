{lib, ...}: {
  removeMeta = bannerPalette:
    builtins.removeAttrs bannerPalette [
      "author"
      "scheme"
    ];
}
