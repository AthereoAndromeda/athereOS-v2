{...}: {
  imports = [
    ./wlsunset.nix
    ./wayidle/wayidle.nix
  ];
  wayland.windowManager.mango = {
    enable = true;
    # settings = ''
    #   # see config.conf
    # '';
    settings = builtins.readFile ./mango.conf;

    # autostart_sh = ''
    #   # see autostart.sh
    #   # Note: here no need to add shebang
    #   wpaperd
    # '';
  };
}
