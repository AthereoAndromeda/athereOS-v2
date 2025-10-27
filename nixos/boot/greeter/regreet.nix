{pkgs, ...}: {
  environment.systemPackages = [pkgs.cage];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.cage}/bin/cage -s -mlast -- ${pkgs.regreet}/bin/regreet";
        user = "greeter";
      };
    };
  };
  programs.regreet.enable = true;

  programs.regreet.settings = {
    background = {
      path = "/persist/home/athereo/Pictures/Wallpapers/pexels-esan-2085998.jpg";
      fit = "Cover";
    };

    commands = {
      reboot = ["systemctl" "reboot"];

      # The command used to shut down the system
      poweroff = ["systemctl" "poweroff"];
    };
    # The command used to reboot the system

    appearance = {
      greeting_msg = "Welcome back!";
    };
    # The message that initially displays on startup

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
}
