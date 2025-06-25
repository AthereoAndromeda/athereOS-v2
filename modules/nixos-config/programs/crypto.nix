{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kryptor
    age
  ];
}
