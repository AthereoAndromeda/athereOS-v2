{
  nixpkgs,
  pkgs,
  inputs,
  custom-utils,
  ...
}: {
  nixpkgs.overlays = map (f: import (builtins.toPath f) {inherit pkgs inputs;}) (
    custom-utils.list-nix-files (p: p != ./default.nix) ./.
  );
}
