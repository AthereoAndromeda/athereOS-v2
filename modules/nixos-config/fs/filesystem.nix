{...}: {
  programs.fuse.userAllowOther = true;

  fileSystems."/".options = ["compress=zstd" "noatime"];
  fileSystems."/nix".options = ["compress=zstd" "noatime"];
  fileSystems."/persist".options = ["compress=zstd" "noatime"];
  fileSystems."/persist".neededForBoot = true;

  fileSystems."/var/log".options = ["compress=zstd" "noatime"];
  fileSystems."/var/log".neededForBoot = true;
}
