{pkgs, ...}: {
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    rofi
    playerctl
    libnotify
    brightnessctl
    eww
  ];
}
