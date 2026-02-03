{pkgs, ...}: {
  imports = [
    # ./quickshell
  ];

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
