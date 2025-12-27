{...}: {
  programs.fuse.userAllowOther = true;

  fileSystems."/".options = ["compress=zstd" "noatime"];
  fileSystems."/nix".options = ["compress=zstd" "noatime"];
  fileSystems."/persist".options = ["compress=zstd" "noatime"];
  fileSystems."/persist".neededForBoot = true;

  fileSystems."/var/log".options = ["compress=zstd" "noatime"];
  fileSystems."/var/log".neededForBoot = true;

  fileSystems."/old_roots" = {
    device = "/dev/disk/by-uuid/f6b77848-b9cb-4657-bf8d-e2e2819f980c"; # Use your UUID here if possible
    fsType = "btrfs";
    options = ["subvol=old_roots" "compress=zstd" "noatime"];
  };
}
