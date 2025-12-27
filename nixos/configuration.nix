# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
in {
  # NOTE(imports): Modules are automatically imported from `./default.nix`

  # NOTE: When adding a new shell, always enable the shell system-wide, even if it's already enabled in your
  # Home Manager configuration, otherwise it won't source the necessary files.
  # https://nixos.wiki/wiki/Command_Shell (2025-06-24)
  # programs.fish.enable = true;

  # Takes way too much time building man caches each rebuild
  documentation.man.generateCaches = false;

  # desktop-environment.gnome.enable = true;
  bootloader.grub.enable = true;

  # Note, if you use the NixOS module and have useUserPackages = true, make sure to add
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"

    "/share/nushell"
  ];

  environment.shells = [pkgs.bashInteractive pkgs.nushell];

  # Fingerprint scanner on my device is not supported :<
  # systemd.services.fprintd = {
  #   wantedBy = ["multi-user.target"];
  #   serviceConfig.Type = "simple";
  # };

  # # Install the driver
  # services.fprintd.enable = true;
  # services.fprintd.tod.enable = true;
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix; # Goodix driver module

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libGL
  ];

  networking.hostName = "athereo-lenovo-nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Manila";
  # Prevents dual boot Windows getting wrong time
  time.hardwareClockInLocalTime = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.udev.packages = with pkgs; [
    gnome-settings-daemon
  ];

  hardware.sensor.iio.enable = true;
  services.sysprof.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
