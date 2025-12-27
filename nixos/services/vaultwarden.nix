{...}: {
  services.vaultwarden.enable = false;
  services.vaultwarden.config = {
    DOMAIN = "http://localhost";
    ROCKET_ADDRESS = "0.0.0.0";
    ROCKET_PORT = 8222;

    ROCKET_LOG = "critical";
  };
}
