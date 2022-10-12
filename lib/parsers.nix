{lib, ...}: rec {
  evalYamlString = string: let
    removeSurroundingQuotes = string:
      lib.strings.removePrefix "\""
      (lib.strings.removeSuffix "\"" string);
    isNumeric = yaml: let
      numbers = {
        "1" = 1;
        "2" = 2;
        "3" = 3;
        "4" = 4;
        "5" = 5;
        "6" = 6;
        "7" = 7;
        "8" = 8;
        "9" = 9;
        "0" = 0;
      };
    in
      builtins.any
      (item: builtins.hasAttr item numbers)
      (lib.strings.stringAsChars yaml);
    eval =
      if lib.strings.hasSuffix "\"" string && lib.strings.hasPrefix "\"" string
      then removeSurroundingQuotes
      else if isNumeric string
      then lib.strings.toInt string
      else string;
  in
    eval string;
  basicYamlToBanner =
    # this function only works for yaml with a depth of 1
    # ie. simple key-value pairs. same format of base16 and
    # banner palettes
    yaml: let
      # helper function
      removeAll = listOfThingsToRemove: list: (
        lib.lists.foldr
        (next: prev: lib.lists.remove next prev)
        list # start out with the original list
        
        listOfThingsToRemove # iterate over this list
      );

      removeComments = list: let
        # if an item in the list starts with a #, remove it
        cleanedList =
          lib.lists.foldr (next: prev: let
            characters = removeAll ["" " " "\t"] (lib.strings.splitString "" next);
            firstChar = builtins.elemAt characters 0;
          in (
            if firstChar == "#"
            then prev
            else [next] ++ prev
          )) []
          list;
      in
        cleanedList;

      # get all the lines from the yaml file
      lines =
        removeComments
        (removeAll
          ["" "\n" " " " \n"]
          (lib.strings.splitString "\n" (builtins.readFile yaml)));

      listOfAttrs =
        map (line: let
          characters = removeAll ["" " " "\n" "\t"] (lib.strings.splitString "" line);
          rejoinedLine =
            (lib.lists.foldr (next: prev:
                if prev.is_comment
                then prev
                else if next == "#"
                then {
                  inherit (prev) string;
                  is_comment = true;
                }
                else {
                  string = prev.string + next;
                  is_comment = false;
                }) {
                string = "";
                is_comment = false;
              }
              (lib.lists.reverseList characters))
            .string;
          fixes = lib.strings.splitString ":" rejoinedLine;
          name = builtins.elemAt fixes 0;
          value = evalYamlString (builtins.elemAt fixes 1);
        in {
          inherit name value;
        })
        lines;

      attrs = builtins.listToAttrs listOfAttrs;
    in
      attrs;
}
