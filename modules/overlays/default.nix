{
  nixpkgs,
  pkgs,
  inputs,
  ...
}: let
  inherit (builtins) filter map toString toPath;
  inherit (nixpkgs.lib.filesystem) listFilesRecursive;
  inherit (nixpkgs.lib.strings) hasSuffix;
in {
  nixpkgs.overlays = map (x: import (toPath x) {inherit pkgs inputs;}) (filter (hasSuffix ".nix") (
    map toString (filter (p: p != ./default.nix) (listFilesRecursive ./.))
  ));
}
