# banner.nix lib documentation

(needs work lol)

## color

Color-processing utility functions

**hasOctothorpe**
args: ``s``
Returns true if the first character of string ``s`` is an octothorpe (#).

**removeLeadingOctothorpe**
Returns all of the characters after a leading octothorpe. Aborts evaluation
if a leading octothorpe is not present.

**decimalToHex**
Converts any hexadecimal number as a string into a decimal number.

**twoDigitHexToDecimal**
Converts a two-character string hexadecimal number into a decimal number.

**toNix**
Converts a color in any format to a nix attrset containing
r, g, b, and a values.

**toHex**
Converts a color in any format to a hexcode color.

**distances.euclidian**
args: ``c1 c2``
Calculates the simple euclidian distance between colors c1 and c2.

## parsers

This section contains functions for parsing text files into nix
attrsets.

**basicYamlToBanner:**
This converts basic yaml to a banner palette. However, it only
works on simple yaml with a depth of 1: ie. A set of key-value
pairs in a big list, such as [this banner palette example.](https://github.com/the-argus/banner/example.yaml)
