{
  pkgs,
  nixpkgs,
  inputs,
  ...
}: let
  # lib = nixpkgs.lib;
in {
  grub-themes = import ./grub-themes pkgs;
  overlays = import ./overlays {inherit nixpkgs pkgs inputs;};
  persist = import ./persist.nix {};
}
