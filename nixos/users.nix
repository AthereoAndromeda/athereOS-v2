{pkgs, ...}: {
  # Define a plugdev group
  users.groups = {
    plugdev.gid = 1000;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.athereo = {
    isNormalUser = true;
    shell = pkgs.nushell;
    # useDefaultShell = false;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "render"
      "cdrom"
      "adm" # /var/log access
      "lpadmin" # Printer

      "plugdev" # Hot-pluggables (JTAG)
      "libvirtd" # Virt-manager
      "dialout" # Serial Port
      "uucp"
    ];

    hashedPasswordFile = "/persist/password/athereo";
  };
}
