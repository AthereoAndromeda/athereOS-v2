{pkgs, ...}: {
  programs.navi = {
    enable = true;
    enableBashIntegration = true;
  };

  xdg.dataFile = {
    "navi/cheats/athereo__custom-cheats" = {
      source = ./cheats;
      recursive = true;
    };
  };
}
