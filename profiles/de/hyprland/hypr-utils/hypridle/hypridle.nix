{...}: {
  services.hypridle.enable = true;

  xdg.configFile = {
    "hypr/hypridle.conf".source = ./config.hypr;
  };
}
