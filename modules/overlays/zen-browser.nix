{
  inputs,
  pkgs,
  ...
}: (self: super: {
  zen-browser = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
    nativeMessagingHosts = [pkgs.firefoxpwa];
  };
})
