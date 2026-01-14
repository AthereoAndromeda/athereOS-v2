{pkgs, ...}: {
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    nix-index

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
    pulseaudioFull
    timg

    # TUI
    yazi
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

  # In NixOS setup since I need virtual camera
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
  };
}
