{...}: {
  # Create timestamp
  systemd.tmpfiles.rules = [
    "d /var/db/sudo 0711 root root -"
    "d /var/db/sudo/ts 0700 root root -"

    "d /var/db/sudo-rs 0711 root root -"
    "d /var/db/sudo-rs/ts 0700 root root -"
  ];

  security.sudo = {
    # enable = false;
    execWheelOnly = true;

    extraConfig = ''
      # 15 Minute sudo timeout
      Defaults    timestamp_timeout=15

      # rollback results in sudo lectures after each reboot
      Defaults    lecture = never
    '';
  };

  # Alternative
  security.sudo-rs = {
    enable = true;
    execWheelOnly = true;
    wheelNeedsPassword = true;

    extraConfig = ''
      # 15 Minute sudo timeout
      Defaults   timestamp_timeout=15
      # Defaults   timestampdir=/var/db/sudo/ts

      # NOTE: sudo-rs does not implement
      # rollback results in sudo lectures after each reboot
      # Defaults    lecture=never
    '';
  };
}
