{...}: {
  programs.fastfetch = {
    enable = true;
    # settings = import ./25.ni;
  };

  xdg.configFile = {
    "fastfetch/config.jsonc".source = ./25.jsonc;
  };
}
