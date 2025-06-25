pkgs:
pkgs.stdenv.mkDerivation {
  pname = "CRTAmber-grub-theme";
  version = "1.1";
  src = pkgs.fetchFromGitHub {
    owner = "Jacksaur";
    repo = "CRT-Amber-GRUB-Theme";
    rev = "91c376037d6fe2eb62b82cb5f7b5148438c8ed77";
    hash = "sha256-ATm0b9e3Qcv42E5CQYB7Umc8NpWw90QdjJmArOKbmaY=";
  };
  installPhase = "cp -r $src $out";
}
