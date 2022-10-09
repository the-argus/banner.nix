{lib, ...}: {
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
            characters = removeAll [" " "\t"] (lib.strings.splitString "" next);
            firstChar = builtins.elemAt characters 0;
          in (
            if firstChar == "#"
            then prev
            else prev ++ [next]
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
          characters = removeAll [" " "\n" "\t"] (lib.strings.splitString "" line);
          rejoinedLine = builtins.concatStringsSep "" characters;
          fixes = builtins.trace rejoinedLine (lib.strings.splitString ":" rejoinedLine);
          name = builtins.elemAt fixes 0;
          value = builtins.elemAt fixes 1;
        in {
          inherit name value;
        })
        lines;

      attrs = builtins.listToAttrs listOfAttrs;
    in
      attrs;
}
