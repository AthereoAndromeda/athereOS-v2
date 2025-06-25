{pkgs, ...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    package = pkgs.git.override {
      withLibsecret = true;
    };

    userName = "Athereo";
    userEmail = "athereoandromeda@gmail.com";

    aliases = {
      st = "status";
      br = "branch";
      sw = "switch";
      ch = "checkout";
    };

    # Better diff view
    delta.enable = true;

    extraConfig = {
      credential.helper = "libsecret";
      init.defaultBranch = "main";
    };
  };
}
