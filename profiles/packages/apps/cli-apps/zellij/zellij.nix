{...}: {
  programs.zellij = {
    enable = true;
    # settings = builtins.readFile ./config.kdl;
  };

  xdg.configFile = {
    "zellij/config.kdl".source = ./config.kdl;
  };
}
