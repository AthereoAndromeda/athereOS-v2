{pkgs, ...}: {
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
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
  ];
}
