{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./packages # Auto-imports all .nix files in packages/
    inputs.xdg-termfilepickers.homeManagerModules.default
    inputs.mango.hmModules.mango

    # ./de/gnome/dconf.nix
    # ./de/hyprland/hypr.nix
    ./de/common
    ./de/mango/mango.nix
  ];

  # Enable base dirs
  xdg.enable = true;

  # TODO: fix XDG Portals
  xdg.portal.enable = true;
  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    # xdg-desktop-portal-termfilechooser
  ];

  xdg.portal.config = {
    common = {
      default = [
        "gnome"
        "gtk"
      ];

      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
    };
  };

  # services.xdg-desktop-portal-termfilepickers = let
  #   termfilepickers = inputs.xdg-termfilepickers.packages.${pkgs.system}.default;
  # in {
  #   enable = true;
  #   package = termfilepickers;
  #   config = {
  #     terminal_command = [(lib.getExe pkgs.ghostty) "--title=filepicker" "-e"];
  #   };
  # };

  home.stateVersion = "25.05";
  home.homeDirectory = "/home/athereo";
  home.packages = with pkgs; [
    zen-browser
    xh
    fend
    grim
    slurp
  ];

  programs.thunderbird = {
    enable = true;

    profiles.athereo = {
      isDefault = true;
    };
  };

  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;
}
