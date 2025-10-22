{pkgs, ...}: {
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # CLI Utils
    fd
    btop
    caligula
    fzf
    ripgrep
    xh
    just
    just-lsp
    mask
    sttr

    # TUI
    wezterm
    kitty
    fastfetch
    nushell
    ghostty
    wget
    firefox
    helix
    git
    mpv
    xcp
    binsider
    posting
  ];

  programs.television = {
    enable = true;
    enableBashIntegration = true;
  };
}
