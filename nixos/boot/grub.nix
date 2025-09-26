{
  config,
  lib,
  grub-themes,
  ...
}: {
  options = {
    bootloader.grub.enable = lib.mkEnableOption "enables thing";
  };

  config = lib.mkIf config.bootloader.grub.enable {
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      theme = grub-themes.crt-amber;

      # Play mario theme
      # extraConfig = ''
      #   play 410 668 1 668 1 0 1 668 1 0 1 522 1 668 1 0 1 784 2 0 2 392 2
      # '';

      # minegrub-theme = {
      #   enable = true;
      #   splash = "100% Reproducible Goodness!";
      #   background = "background_options/1.20 - [Trails & Tales].png";
      #   boot-options-count = 4;
      # };
    };
  };
}
