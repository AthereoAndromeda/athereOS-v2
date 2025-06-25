{lib, ...}: {
  # Enable the X11 windowing system.
  services.xserver.enable = lib.mkDefault true;
  programs.xwayland.enable = lib.mkDefault true;
}
