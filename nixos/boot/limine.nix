{
  config,
  lib,
  ...
}: let
  cfg = config.bootloader.limine;
in {
  options = {
    bootloader.limine.enable = lib.mkEnableOption "Enable Limine Bootloader";
  };

  config = lib.mkIf cfg.enable {
    boot.loader.limine = {
      enable = true;
      efiSupport = true;
      enableEditor = true;

      style = {
        wallpaperStyle = "centered";

        interface = {
          branding = "Best laptop within a 1km radius";
        };
      };

      extraEntries = ''
        /Windows
          protocol: efi
          path: uuid(7690d36f-bbbe-460c-bf66-44b771c8889a):/EFI/Microsoft/Boot/bootmgfw.efi
      '';
    };
  };
}
