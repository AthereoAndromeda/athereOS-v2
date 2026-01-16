{pkgs, ...}: {
  environment.systemPackages = with pkgs; [cage greetd regreet];

  services.greetd = {
    enable = true;
  };

  environment.etc."regreet/wallpaper.jpg" = {
    source = "/persist/home/athereo/Pictures/Wallpapers/wp3028467-purple-space-wallpapers.jpg";
    mode = "0444";
  };

  programs.regreet = {
    enable = true;
    cageArgs = ["-s" "-d" "-m" "last"];

    cursorTheme = {
      name = "LyraQ-cursors";
      package = pkgs.lyra-cursors;
    };

    settings = {
      background = {
        path = "/etc/regreet/wallpaper.jpg";
        fit = "Cover";
      };

      commands = {
        reboot = ["systemctl" "reboot"];
        poweroff = ["systemctl" "poweroff"];
      };

      appearance = {
        # The message that initially displays on startup
        greeting_msg = "Welcome back saar!";
      };

      widget.clock = {
        # strftime format argument
        # See https://docs.rs/jiff/0.1.14/jiff/fmt/strtime/index.html#conversion-specifications
        format = "%A, %d %b %Y %H:%M";

        # How often to update the text
        resolution = "500ms";

        # Override system timezone (IANA Time Zone Database name, aka /etc/zoneinfo path)
        # Remove to use the system time zone.
        timezone = "Asia/Manila";

        # Ask GTK to make the label at least this wide. This helps keeps the parent element layout and width consistent.
        # Experiment with different widths, the interpretation of this value is entirely up to GTK.
        label_width = 350;
      };

      GTK = {
        application_prefer_dark_theme = true;
      };
    };
  };
}
