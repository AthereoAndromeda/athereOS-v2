{config, ...}: let
  inherit (config.home.sessionVariables) XCURSOR_THEME XCURSOR_SIZE;
in {
  imports = [
    ./wlsunset.nix
    ./wayidle/wayidle.nix
  ];

  wayland.windowManager.mango = {
    enable = true;
    # settings = ''
    #   # see config.conf
    # '';
    # settings = builtins.readFile ./mango.conf;

    # autostart_sh = ''
    #   # see autostart.sh
    #   # Note: here no need to add shebang
    #   wpaperd
    # '';
  };

  xdg.configFile = {
    "mango" = {
      recursive = true;
      source = ./config;
    };

    "mango/cursors.conf".text = ''
      cursor_theme=${XCURSOR_THEME}
      cursor_size=${XCURSOR_SIZE}
    '';
  };
}
