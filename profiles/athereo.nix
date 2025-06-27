{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  gnome-extensions = with pkgs.gnomeExtensions; [
    blur-my-shell
    just-perfection
    appindicator
    dash-to-dock
  ];
in {
  imports = [
    ./packages # Auto-imports all .nix files in packages/
    inputs.xdg-termfilepickers.homeManagerModules.default
  ];

  # TODO: fix XDG Portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gnome
    xdg-desktop-portal-termfilechooser
  ];

  xdg.portal.config = {
    common = {
      default = [
        "gnome"
      ];

      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
    };
  };

  services.xdg-desktop-portal-termfilepickers = let
    termfilepickers = inputs.xdg-termfilepickers.packages.${pkgs.system}.default;
  in {
    enable = true;
    package = termfilepickers;
    config = {
      terminal_command = lib.getExe pkgs.kitty;
    };
  };

  home.stateVersion = "25.05";
  home.homeDirectory = "/home/athereo";
  home.packages = with pkgs;
    [
      zen-browser
      xh
      fend
    ]
    ++ gnome-extensions;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
    };

    "org/gnome/desktop/background" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/map-l.svg";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/map-d.svg";
      primary-color = "#241f31";
    };

    "org/gnome/screensaver" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/map-l.svg";
      primary-color = "#241f31";
    };

    "org/gnome/shell" = {
      welcome-dialog-last-shown-version = "999"; # prevent popup until gnome version 999 :)
      disable-user-extensions = false; # enables user extensions
      enabled-extensions = builtins.map (x: x.extensionUuid) gnome-extensions;

      # Places apps on Dock
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "com.mitchellh.ghostty.desktop"
        "zen-beta.desktop"
        "thunderbird.desktop"
      ];
    };

    "org/gnome/desktop/interface".color-scheme = "prefer-dark";

    "org/gnome/shell/extensions/just-perfection" = {
      # Visibility
      support-notifier-type = 0; # Disable popup
      accessibility-menu = false; # Turn off accessibility menu from panel
      keyboard-layout = false;
      search = false;

      # Behavior
      workspace-wrap-around = true; # Wraps around

      # Customize
      accent-color-icon = true;
      dash-icon-size = 32;
      max-displayed-search-results = 0; # Set to default number
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-fixed = false;
      extend-height = true;
      always-center-icons = true;
      dash-max-icon-size = 32;
      isolate-workspaces = true;
      show-show-apps-button = false;
      show-trash = true;
      scroll-action = "cycle-windows";
      custom-theme-shrink = true;
    };
  };

  programs.thunderbird = {
    enable = true;

    profiles.athereo = {
      isDefault = true;
    };
  };

  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;
}
