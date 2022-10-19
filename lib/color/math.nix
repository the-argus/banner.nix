{lib, ...}: let
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
  dec2HexDigits = rec {
    "0" = "0";
    "1" = "1";
    "2" = "2";
    "3" = "3";
    "4" = "4";
    "5" = "5";
    "6" = "6";
    "7" = "7";
    "8" = "8";
    "9" = "9";
    "10" = "A";
    "11" = "B";
    "12" = "C";
    "13" = "D";
    "14" = "E";
    "15" = "F";
  };
in rec {
  decimalToHex = decimal: let
    strDecimal =
      if builtins.typeOf decimal == "string"
      then decimal
      else if builtins.typeOf decimal == "int"
      then "${builtins.toString decimal}"
      else abort "decimalToHex does not support ${builtins.typeOf decimal}";

    hexNumber =
      lib.lists.foldr
      (next: prev: (dec2HexDigits.${next} + prev))
      ""
      (lib.strings.splitString "." strDecimal);
  in
    hexNumber;

  twoDigitHexToDecimal = hex:
  # stolen straight from SenchoPens/base16.nix
    (16 * hex2decDigits."${builtins.substring 0 1 hex}")
    + hex2decDigits."${builtins.substring 1 2 hex}";

  sqr = value: value * value;
  pow = num: exponent: (lib.lists.foldr
    (next: prev: prev * num)
    0
    (lib.lists.range 1 exponent));
}
