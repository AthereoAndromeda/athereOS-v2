{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    rofi
    playerctl
    libnotify
    brightnessctl
    eww
  ];
}
