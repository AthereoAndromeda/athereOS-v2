{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva
      libvdpau-va-gl
    ];
  };

  services.xserver.videoDrivers = ["amdgpu"];
}
