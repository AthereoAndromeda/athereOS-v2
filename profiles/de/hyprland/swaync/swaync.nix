{pkgs, ...}: let
  inherit (builtins) readFile fromJSON;
  build-scss = path:
    pkgs.stdenv.mkDerivation {
      name = "sass-builder";
      src = path;

      nativeBuildInputs = with pkgs; [
        dart-sass
      ];

      dontUnpack = true;
      dontPatch = true;
      dontConfigure = true;
      dontInstall = true;

      buildPhase = ''
        mkdir -p $out

        echo "Building SCSS..."
        sass $src:$out/dist
      '';
    };

  jsonc2json = path:
    pkgs.stdenv.mkDerivation {
      name = "jsonc2json";
      src = path;

      nativeBuildInputs = with pkgs; [
      ];
    };
in {
  services.swaync = {
    enable = true;
    style = readFile "${build-scss ./scss}/dist/style.css";
    # config = fromJSON (readFile ./config.jsonc);
  };
}
