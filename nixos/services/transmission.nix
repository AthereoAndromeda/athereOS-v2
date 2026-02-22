{pkgs, ...}: {
  services.transmission = {
    enable = true;
    package = pkgs.transmission_4-gtk;
  };

  environment.systemPackages = [
    pkgs.transmission-remote-gtk
    pkgs.fragments
  ];
}
