{pkgs, ...}: {
  programs.mango.enable = true;

  environment.systemPackages = with pkgs; [
    foot
    wmenu
    wl-clipboard
    grim
    slurp
  ];
}
