{lib, ...}: let
  blib = import ./.;
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
        then "${value}${builtins.elemAt digits (index - 1)}"
        else null)
      digits);
  in
    builtins.listToAttrs (lib.lists.imap0 (index: value: {
      name = builtins.elemAt hexValueNames index;
      value = blib.twoDigitHexToDecimal value;
    }) (listOfTwoDigitGroups hex));

  stringToNix = string: let
    convert =
      if lib.trivial.mod (builtins.stringLength string) 2 == 0
      then hexToNix
      else (hex: hexToNix (blib.removeLeadingOctothorpe hex));
  in
    convert string;

  # use this one if the color is already an attrset
  passthrough = value: value;

  nixToHex = nix: let
    hexValues = builtins.mapAttrs (name: value: blib.decimalToTwoDigitHex value);
  in "${hexValues.r}${hexValues.g}${hexValues.b}";
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
}
