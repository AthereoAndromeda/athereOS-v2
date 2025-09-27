{pkgs, ...}: {
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    mako
    rofi
    playerctl
    libnotify
    brightnessctl
    eww
  ];
}
