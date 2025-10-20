{...}: {
  imports = [
    ./hypr-utils/hyprlock/hyprlock.nix
  ];
  services.hyprpolkitagent.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
    # plugins = with pkgs.hyprlandPlugins; [
    #   hyprexpo
    # ];
  };

  xdg.configFile = {
    "hypr/config" = {
      source = ./config;
      recursive = true;
    };
  };
}
