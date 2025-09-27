{pkgs, ...}: let
  gnome-extensions = with pkgs.gnomeExtensions; [
    blur-my-shell
    just-perfection
    appindicator
    dash-to-dock
    tiling-shell
  ];
in {
  home.packages = gnome-extensions;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
      enable-hot-corners = false;
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
}
