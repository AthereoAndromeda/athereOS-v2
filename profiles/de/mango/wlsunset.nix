{...}: {
  services.wlsunset = {
    enable = true;
    gamma = 0.8;

    sunrise = "06:00";
    sunset = "20:00";

    temperature = {
      day = 6500;
      night = 4000;
    };
  };
}
