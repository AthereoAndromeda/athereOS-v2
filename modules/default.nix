{
  pkgs,
  nixpkgs,
  inputs,
  custom-utils,
  ...
}: let
  # lib = nixpkgs.lib;
in {
  grub-themes = import ./grub-themes pkgs;
  overlays = import ./overlays {inherit nixpkgs pkgs inputs custom-utils;};
  persist = import ./persist.nix {};
}
