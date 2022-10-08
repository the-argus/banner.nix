{lib, ...}: let
  blib = import ./.;
in {
  euclidian = color1: color2: let
    convert =
      if builtins.typeOf color == "string"
      then blib.toNix
      else if builtins.typeOf color != "set"
      then
        abort ''
          Euclidian distance cannot be calculator for color of
          type ${builtins.typeOf color}. Use a hex string or a nix attrset.
        ''
      else (value: value);

    distanceBetween = with blib;
      color1: color2:
        (square (color1.r - color2.r))
        + (square (color1.g - color2.g))
        + (square (color1.b - color2.b));
  in (distanceBetween (convert color1) (convert color2));
}
