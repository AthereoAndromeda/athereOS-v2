{...}: {
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };

  xdg.configFile = {
    "starship.toml".source = ./zerodds-theme.toml;
    # "starship.toml".source = ./miha77777ua-theme.toml;
  };
}
