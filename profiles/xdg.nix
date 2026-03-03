{pkgs, ...}: {
  xdg = {
    enable = true;

    # TODO: fix XDG Portals
    portal.enable = true;
    portal.xdgOpenUsePortal = true;
    portal.extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      # xdg-desktop-portal-termfilechooser
    ];

    portal.config = {
      common = {
        default = "gtk";

        # Use the 'wlr' portal for screen sharing/specific wayland tasks
        "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
        "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
        "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      };
    };

    userDirs = {
      enable = true;
      createDirectories = true;
    };

    # services.xdg-desktop-portal-termfilepickers = let
    #   termfilepickers = inputs.xdg-termfilepickers.packages.${pkgs.stdenv.hostPlatform.system}.default;
    # in {
    #   enable = true;
    #   package = termfilepickers;
    #   config = {
    #     terminal_command = [(lib.getExe pkgs.ghostty) "--title=filepicker" "-e"];
    #   };
    # };
  };
  # Enable base dirs
}
