{pkgs, ...}: let
  udev-pkg = pkgs.stdenv.mkDerivation {
    name = "probe-rs-udev";
    src = ./69-probe-rs.rules;
    phases = ["installPhase"];

    installPhase = ''
      mkdir -p $out/lib/udev/rules.d
      cp $src $out/lib/udev/rules.d/69-probe-rs.rules
    '';
  };
in {
  services.udev.packages = [udev-pkg];
}
