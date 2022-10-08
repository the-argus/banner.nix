# banner.nix lib documentation

## color

**hasOctothorpe**
args: ``str``
Returns true if the first character of a string is an octothorpe (#).

## parsers

This section contains functions for parsing text files into nix
attrsets.

**basicYamlToBanner:**
This converts basic yaml to a banner palette. However, it only
works on simple yaml with a depth of 1: ie. A set of key-value
pairs in a big list, such as [this banner palette example.](https://github.com/the-argus/banner/example.yaml)
