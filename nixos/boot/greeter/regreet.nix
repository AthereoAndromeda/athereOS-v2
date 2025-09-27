{...}: {
  services.greetd.enable = true;
  programs.regreet.enable = true;

  programs.regreet.settings = {
    default_session = {
      command = "Hyprland --config /home/athereo/.config/hypr/hyprland.conf";
      user = "greeter";
    };

    GTK = {
      application_prefer_dark_theme = true;
    };
  };
}
