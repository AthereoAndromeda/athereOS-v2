{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.xdg-termfilepickers.homeManagerModules.default
    inputs.gazelle.homeModules.gazelle
    # inputs.mango.hmModules.mango
    ./packages # Auto-imports all .nix files in packages/
    ./services
    ./scripts
    ./xdg.nix

    # ./de/gnome/dconf.nix
    # ./de/hyprland/hypr.nix
    ./de/common
    ./de/niri/niri.nix
    # ./de/mango/mango.nix
  ];

  programs.gazelle = {
    enable = true;
    settings = {
      theme = "rose-pine-moon";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.stateVersion = "25.05";
  home.homeDirectory = "/home/athereo";
  home.packages = with pkgs; [
    zen-browser
    chromium
    thunderbird-latest
    xh
    fend
    grim
    slurp
    wl-mirror
    swappy

    inputs.gazelle.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home.sessionVariables = {
    XCURSOR_THEME = "LyraQ-cursors";
    XCURSOR_SIZE = "48";
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1"; # Fixes logisim-evolution being a blank white screen

    # XDG_PICTURES_DIR = "/home/athereo/Pictures";
  };

  home.pointerCursor = {
    gtk.enable = true;
    enable = true;
    package = pkgs.lyra-cursors;
    name = config.home.sessionVariables.XCURSOR_THEME;
    size = config.home.sessionVariables.XCURSOR_SIZE;
  };

  home.shell.enableBashIntegration = true;
  home.shell.enableNushellIntegration = true;

  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;
}
