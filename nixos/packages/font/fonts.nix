{pkgs, ...}: let
  install-font = path:
    pkgs.runCommand "install-font" {} ''
      mkdir -p $out/share/fonts/truetype

      # -L follows symlinks if the directory is a Nix store path
      # -iregex allows case-insensitive matching for various extensions
      find -L ${path} -type f \( -iname "*.ttf" -o -iname "*.otf" -o -iname "*.woff" -o -iname "*.woff2" \) \
        -exec cp -t $out/share/fonts/truetype/ {} +
    '';
in {
  environment.systemPackages = [
    pkgs.gnome-font-viewer
  ];

  fonts.packages = with pkgs.nerd-fonts;
    [
      jetbrains-mono
      sauce-code-pro
    ]
    ++ [
      (install-font ./library-3-am-font)
    ];
}
