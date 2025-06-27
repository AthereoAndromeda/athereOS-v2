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
      unstage = "restore -S";
      discard = "restore -S -W";
      uncommit = "reset --soft HEAD^";
      dic = "diff --cached";

      lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
      lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
    };

    # Better diff view
    delta.enable = true;

    extraConfig = {
      credential.helper = "libsecret";
      init.defaultBranch = "main";
      submodule.recurse = true;
    };
  };
}
