{config, ...}: {
  programs.nushell = {
    enable = true;
    environmentVariables = config.home.sessionVariables;

    envFile.text = ''
      zoxide init nushell | save -f ~/.zoxide.nu
      just --completions nushell | save -f ~/.just.nu
    '';

    configFile.text = ''
      source ~/.zoxide.nu
      source ~/.just.nu
    '';
  };
}
