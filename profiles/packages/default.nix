{custom-utils, ...}: {
  imports = custom-utils.list-nix-files (p: p != ./default.nix) ./.;
}
