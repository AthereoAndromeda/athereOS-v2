{pkgs, ...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    package = pkgs.git.override {
      withLibsecret = true;
    };

    settings = {
      credential.helper = "libsecret";
      init.defaultBranch = "main";
      submodule.recurse = true;

      user = {
        name = "Athereo";
        email = "athereoandromeda@gmail.com";
      };

      alias = {
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

        # Commands with fzf
        addm = "!git ls-files --deleted --modified --other --exclude-standard | fzf -0 -m --preview 'git diff --color=always {-1}' | xargs -r git add";
        addmp = "!git ls-files --deleted --modified --exclude-standard | fzf -0 -m --preview 'git diff --color=always {-1}' | xargs -r -o git add -p";
        cb = "!git branch --all | grep -v '^[*+]' | awk '{print $1}' | fzf -0 --preview 'git show --color=always {-1}' | sed 's/remotes\\/origin\\///g' | xargs -r git checkout";
        cs = "!git stash list | fzf -0 --preview 'git show --pretty=oneline --color=always --patch \"$(echo {} | cut -d: -f1)\"' | cut -d: -f1 | xargs -r git stash pop";
        db = "!git branch | grep -v '^[*+]' | awk '{print $1}' | fzf -0 --multi --preview 'git show --color=always {-1}' | xargs -r git branch --delete";
        Db = "!git branch | grep -v '^[*+]' | awk '{print $1}' | fzf -0 --multi --preview 'git show --color=always {-1}' | xargs -r git branch --delete --force";
        ds = "!git stash list | fzf -0 --preview 'git show --pretty=oneline --color=always --patch \"$(echo {} | cut -d: -f1)\"' | cut -d: -f1 | xargs -r git stash drop";
        edit = "!git ls-files --modified --other --exclude-standard | sort -u | fzf -0 --multi --preview 'git diff --color {}' | xargs -r $EDITOR -p";
        fixup = "!git log --oneline --no-decorate --no-merges | fzf -0 --preview 'git show --color=always --format=oneline {1}' | awk '{print $1}' | xargs -r git commit --fixup";
        resetm = "!git diff --name-only --cached | fzf -0 -m --preview 'git diff --color=always {-1}' | xargs -r git reset";
      };
    };
  };

  # Better diff view
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
