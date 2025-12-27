{lib, ...}: {
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = lib.mkDefault 5;

  boot.initrd = {
    enable = true;
    supportedFilesystems = ["btrfs" "ntfs"];

    postResumeCommands = lib.mkAfter ''
      mkdir -p /mnt

      # 1. Mount the top-level BTRFS partition to access all subvolumes
      # so we can manipulate btrfs subvolumes.
      # mount -o subvol=/ /dev/nvme0n1p5 /mnt
      mount -t btrfs -o subvol=/ /dev/disk/by-uuid/f6b77848-b9cb-4657-bf8d-e2e2819f980c /mnt

      # 2. Prepare the backup: Snapshot the CURRENT root before we destroy it
      # We use a subvolume 'old_roots' to store these snapshots
      if [[ -e /mnt/root ]]; then
        mkdir -p /mnt/old_roots
        timestamp=$(date --date="@$(stat -c %Y /mnt/root)" "+%Y-%m-%-d_%H:%M:%S")
        # mv /mnt/root "/mnt/old_roots/$timestamp"
        btrfs subvolume snapshot /mnt/root "/mnt/old_roots/$timestamp"
      fi

      # 3. Cleanup: Delete subvolumes inside /root so we can delete /root itself
      # BTRFS cannot delete a subvolume if it contains other subvolumes.

      # While we're tempted to just delete /root and create
      # a new snapshot from /root-blank, /root is already
      # populated at this point with a number of subvolumes,
      # which makes `btrfs subvolume delete` fail.
      # So, we remove them first.
      #
      # /root contains subvolumes:
      # - /root/var/lib/portables
      # - /root/var/lib/machines
      delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/mnt/$i"
        done
        btrfs subvolume delete "$1"
      }

      if [[ -e /mnt/root ]]; then
        echo "Cleaning up current /root..."
        delete_subvolume_recursively "/mnt/root"
      fi

      # 4. Restore: Create a fresh /root from our blank template
      echo "restoring blank /root subvolume..."
      btrfs subvolume snapshot /mnt/root-blank /mnt/root

      # 5. Retention: Delete snapshots in old_roots older than 7 days
      echo "Cleaning up backups older than 7 days..."
      for snapshot in $(find /mnt/old_roots/ -maxdepth 1 -mtime +7); do
        if [[ "$snapshot" != "mnt/old_roots" ]]; then
          echo "Expiring old backup: $snapshot"
          delete_subvolume_recursively "$snapshot"
        fi
      done

      # Once we're done rolling back to a blank snapshot,
      # we can unmount /mnt and continue on the boot process.
      umount /mnt
    '';
  };
}
