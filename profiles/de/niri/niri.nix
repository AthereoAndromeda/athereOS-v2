{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./noctalia/noctalia.nix
  ];

  home.packages = [pkgs.xwayland-satellite-unstable pkgs.nirius];

  programs.niri.settings = {
    xwayland-satellite = {
      enable = true;
      path = lib.getExe pkgs.xwayland-satellite-unstable;
    };
  };

  programs.fuzzel.enable = true;

  xdg.configFile."eww" = {
    recursive = true;
    source = ./eww;
  };

  xdg.configFile."niri" = {
    recursive = true;
    source = ./niri-config;
  };
}
