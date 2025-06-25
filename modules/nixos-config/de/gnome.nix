{
  lib,
  config,
  ...
}: let
in {
  options.desktop-environment.gnome = {
    enable = lib.mkEnableOption "enable gnome DE";
  };
  # Default
  config = lib.mkIf (config.desktop-environment.gnome.enable) {
    # Enable the GNOME Desktop Environment.
    services.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true;
  };
}
