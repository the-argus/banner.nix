{lib, ...}: rec {
  hasOctothorpe = color: builtins.substring 0 1 color == "#";
  removeLeadingOctothorpe = color:
    if hasOctothorpe color
    then builtins.substring 1 (builtins.stringLength color)
    else abort "Color ${color} does not have a leading octothorpe but removal was attempted.";
  twoDigitHexToDecimal = hex:
  # stolen straight from SenchoPens/base16.nix
  let
    hex2decDigits = rec {
      "0" = 0;
      "1" = 1;
      "2" = 2;
      "3" = 3;
      "4" = 4;
      "5" = 5;
      "6" = 6;
      "7" = 7;
      "8" = 8;
      "9" = 9;
      a = 10;
      b = 11;
      c = 12;
      d = 13;
      e = 14;
      f = 15;
      A = a;
      B = b;
      C = c;
      D = d;
      E = e;
      F = f;
    };
  in
    (16 * hex2decDigits."${builtins.substring 0 1 hex}")
    + hex2decDigits."${builtins.substring 1 2 hex}";

  format = let
    hexToNix = hex: let
      hexValueNames = ["r" "g" "b" "a"];
      # group into two-digit sections
      listOfDigits = string:
        lib.lists.remove "" (lib.strings.splitString "" string);
      listOfTwoDigitGroups = string: let
        digits = listOfDigits string;
      in
        lib.lists.remove null (lib.lists.imap1 (index: value:
          if lib.trivial.mod index 2 == 0
          then "${value}${builtins.elemAt digits index-1}"
          else null)
        digits);
    in
      builtins.listToAttrs (imap0 (index: value: {
        name = builtins.elemAt hexValueNames index;
        value = twoDigitHexToDecimal value;
      }) (listOfTwoDigitGroups hex));

    stringToNix = string: let
      convert =
        if lib.trivial.mod (builtins.stringLength string) 2 == 0
        then hexToNix
        else (hex: hexToNix (removeLeadingOctothorpe hex));
    in
      finalString;

    # use this one if the color is already an attrset
    passthrough = value: value;

    nixToHex = nix: let
      hexValues = builtins.mapAttrs (name: value: decimalToTwoDigitHex value);
    in "${hexValues.r}${hexValues.g}${hexvalues.b}";
  in rec {
    toNix = color: let
      convert =
        if builtins.typeOf color == "string"
        then stringToNix
        else if builtins.typeOf color == "set"
        then passthrough
        else
          abort ''
            Type ${
              builtins.typeOf color
            } is not supported by the toNix function.'';
    in
      convert color;
    toHex = color: let
      convert =
        if builtins.typeOf color == "set"
        then nixToHex
        else passthrough;
    in
      convert color;
  };
}
