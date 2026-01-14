{pkgs, ...}: let
  inherit (builtins) readFile;
in {
  programs.niri.config = readFile ./default-config.kdl;
}
