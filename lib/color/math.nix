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
    intDecimal =
      if builtins.typeOf decimal == "string"
      then lib.strings.toInt decimal
      else if builtins.typeOf decimal == "int"
      then decimal
      else abort "decimalToHex does not support ${builtins.typeOf decimal}";

    floatToInt = float: let
      floatStr = builtins.toString float;
      floatStrSplit = lib.strings.splitString "." floatStr;
      intStr = builtins.elemAt floatStrSplit 0;
    in
      lib.strings.toInt intStr;

    hexNumber = int:
      if builtins.typeOf int == "set"
      then
        # we are in the loop
        if int.value < 16
        then
          # exit case, append the last digit and go
          (dec2HexDigits.${builtins.toString int.value}) + int.hex
        else
          # we still need to loop
          hexNumber {
            value = floatToInt (int.value / 16);
            hex =
              (dec2HexDigits
                .${
                  builtins.toString (lib.trivial.mod int.value 16)
                })
              + int.hex;
          }
      else if builtins.typeOf int == "int"
      then
        # initial state, we need to start the loop
        hexNumber {
          value = int;
          hex = "";
        }
      else abort "wat";
  in
    hexNumber intDecimal;

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
