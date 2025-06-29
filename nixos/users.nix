{pkgs, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.athereo = {
    isNormalUser = true;
    extraGroups = ["wheel" "libvirtd"]; # Enable ‘sudo’ for the user.
    shell = pkgs.nushell;
    # useDefaultShell = false;

    hashedPasswordFile = "/persist/password/athereo";
  };
}
