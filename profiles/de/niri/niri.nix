{pkgs, ...}: let
  inherit (builtins) readFile;
in {
  imports = [
    ./quickshell
  ];

  programs.niri.config = readFile ./config.kdl;

  programs.fuzzel.enable = true;
}
