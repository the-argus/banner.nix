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
in rec {
  decimalToHex = decimal: let
    strDecimal =
      if builtins.typeOf decimal == "string"
      then decimal
      else if builtins.typeOf decimal == "int"
      then "${decimal}"
      else abort "decimalToHex does not support ${builtins.typeOf decimal}";

    listOfDigits =
      map
      (value: hex2decDigits.${value})
      (lib.lists.remove "" (lib.strings.splitString "" strDecimal));

    finalNumber =
      lib.lists.foldr (next: prev: {
        index = prev.index + 1;
        value = next * (16 * prev.index);
      }) {
        index = 0;
        value = 0;
      }
      listOfDigits;
  in
    finalNumber.value;

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
