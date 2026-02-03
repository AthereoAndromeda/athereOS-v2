{...}: let
  catppuccin-theme = builtins.fetchGit {
    url = "https://github.com/catppuccin/gitui";
    rev = "df2f59f847e047ff119a105afff49238311b2d36";
  };
in {
  programs.gitui = {
    enable = true;
    theme = builtins.readFile "${catppuccin-theme}/themes/catppuccin-mocha.ron";
  };
}
