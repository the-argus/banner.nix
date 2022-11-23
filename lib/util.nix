{...}: {
  removeMeta = bannerPalette:
    builtins.removeAttrs bannerPalette [
      "author"
      "scheme"
    ];
  makeBase16 = bannerPalette:
    builtins.removeAttrs bannerPalette [
      "highlight"
      "hialt0"
      "hialt1"
      "hialt2"
      "warn"
      "confirm"
      "urgent"
      "link"
      "pfg_highlight"
      "pfg_hialt0"
      "pfg_hialt1"
      "pfg_hialt2"
      "pfg_warn"
      "pfg_confirm"
      "pfg_urgent"
      "pfg_link"
      "pfg-highlight"
      "pfg-hialt0"
      "pfg-hialt1"
      "pfg-hialt2"
      "pfg-warn"
      "pfg-confirm"
      "pfg-urgent"
      "pfg-link"
      "ansi00"
      "ansi01"
      "ansi02"
      "ansi03"
      "ansi04"
      "ansi05"
      "ansi06"
      "ansi07"
    ];
}
