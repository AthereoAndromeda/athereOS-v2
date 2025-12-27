{...}: {
  security.sudo.extraConfig = ''
    # 15 Minute sudo timeout
    Defaults        timestamp_timeout=15

    # rollback results in sudo lectures after each reboot
    Defaults        lecture = never
  '';
}
