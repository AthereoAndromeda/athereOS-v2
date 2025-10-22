{pkgs, ...}: {
  home.packages = with pkgs; [
    wpaperd
  ];

  xdg.configFile = {
    "wpaperd/config.toml".source = ./config.toml;
  };
}
