{pkgs, ...}: {
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    caligula
    wezterm
    kitty
    fzf
    ripgrep
    fastfetch
    nushell
    ghostty
    xh
    alejandra
    just
    just-lsp
    wget
    firefox
    helix
    nixd
    git
    mpv
    xcp
    mask
    sttr
    binsider
    posting
    television
  ];
}
