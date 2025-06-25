{
  inputs,
  pkgs,
  ...
}: (self: super: {
  zen-browser = inputs.zen-browser.packages.${pkgs.system}.default.override {
    nativeMessagingHosts = [pkgs.firefoxpwa];
  };
})
