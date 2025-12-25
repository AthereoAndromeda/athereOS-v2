{pkgs, ...}: {
  fonts.packages = with pkgs.nerd-fonts;
    [
      jetbrains-mono
      sauce-code-pro
    ]
    ++ [
      (pkgs.runCommand "nuixyber-glow" {} ''
        mkdir -p $out/share/fonts/truetype
        cp ${./nuixyber-glow-font/NuixyberGlow-x3KP8.ttf} ${./nuixyber-glow-font/NuixyberGlowNext-3zWjZ.ttf} $out/share/fonts/truetype/
      '')
      (pkgs.runCommand "library-3am" {} ''
        mkdir -p $out/share/fonts/truetype
        cp ${./library-3-am-font/Library3am-5V3Z.otf} ${./library-3-am-font/Library3amsoft-6zgq.otf} $out/share/fonts/truetype/
      '')
    ];
}
