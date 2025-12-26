{
  pkgs,
  inputs,
  ...
}: let
  inherit (builtins) readFile fromJSON;
  jsonc-to-json = inputs.jsonc2json-bin.packages.${pkgs.stdenv.hostPlatform.system}.default;

  build-scss = path:
    pkgs.stdenv.mkDerivation {
      name = "sass-builder";
      src = path;

      nativeBuildInputs = [pkgs.dart-sass];
      phases = ["buildPhase"];

      buildPhase = ''
        mkdir -p $out

        echo "Building SCSS..."
        sass $src:$out/dist
      '';
    };

  build-config = path:
    pkgs.stdenv.mkDerivation {
      name = "config-builder";
      src = path;

      nativeBuildInputs = [jsonc-to-json];
      phases = ["buildPhase"];

      buildPhase = ''
        mkdir -p $out
        echo "Transforming JSONC Config..."
        (cat $src | jsonc-to-json) > $out/config.json
      '';
    };
in {
  services.swaync = {
    enable = true;
    style = readFile "${build-scss ./scss}/dist/style.css";
    settings = fromJSON (readFile "${build-config ./config.jsonc}/config.json");
  };
}
