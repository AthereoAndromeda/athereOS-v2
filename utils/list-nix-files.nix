lib: pred: target: let
  inherit (builtins) filter map toString;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix;
in
  filter (hasSuffix ".nix") (
    map toString (filter pred (listFilesRecursive target))
  )
