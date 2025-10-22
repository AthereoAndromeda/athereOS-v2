{pkgs, ...}: {
  imports = [
    ./hypr-utils
    ./swaync/swaync.nix
  ];
  services.hyprpolkitagent.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
    plugins = with pkgs.hyprlandPlugins; [
      hyprexpo
      # hyprbars
      hyprscrolling
      # hyprspace
      # hyprfocus
    ];
  };

  xdg.configFile = {
    "hypr/config" = {
      source = ./config;
      recursive = true;
    };
  };
}
