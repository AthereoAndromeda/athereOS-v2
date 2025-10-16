{pkgs, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.athereo = {
    isNormalUser = true;
    shell = pkgs.nushell;
    # useDefaultShell = false;
    extraGroups = [
      "wheel"
      "libvirtd"
      "dialout"
    ];

    hashedPasswordFile = "/persist/password/athereo";
  };
}
