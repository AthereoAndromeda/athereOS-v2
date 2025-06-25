{...}: {
  services.xremap = {
    enable = true;
    withGnome = true;
    userName = "athereo";
    yamlConfig = builtins.readFile ./config.yml;
  };
}
