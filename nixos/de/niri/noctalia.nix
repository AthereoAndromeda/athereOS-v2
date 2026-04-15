{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    (
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
        calendarSupport = true;
      }
    )
  ];
}
