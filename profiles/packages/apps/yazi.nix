{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    shellWrapperName = "y";
  };
}
