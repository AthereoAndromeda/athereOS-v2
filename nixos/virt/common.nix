{...}: {
  virtualisation.libvirtd.enable = true;
  users.users.athereo.extraGroups = ["libvirtd"];
}
