{ lib, ...}:
{
  hasOctothorpe = color: builtins.substring 0 1 color == "#";
  removeLeadingOctothorpe = color:
    if hasOctothorpe color
    then builtins.substring 1 (builtins.stringLength color)
    else abort "Color ${color} does not have a leading octothorpe but removal was attempted.";
}
