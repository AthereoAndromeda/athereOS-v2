{
  pkgs,
  lib,
  nixpkgs,
  inputs,
  ...
}: {
  grub-themes = import ./grub-themes pkgs;
  overlays = import ./overlays {inherit nixpkgs pkgs inputs;};
  persist = import ./persist.nix {};
}
