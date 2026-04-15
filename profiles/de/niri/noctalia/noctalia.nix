{...}: let
  inherit (builtins) fromJSON readFile;
  plugins-url = "https://github.com/noctalia-dev/noctalia-plugins";
in {
  programs.noctalia-shell = {
    enable = true;
    settings = fromJSON (readFile ./noctalia.json);

    plugins = {
      version = 2;
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = plugins-url;
        }
      ];

      states = {
        fancy-audiovisualizer = {
          enabled = true;
          sourceUrl = plugins-url;
        };

        mirror-mirror = {
          enabled = true;
          sourceUrl = plugins-url;
        };

        kaomoji-provider = {
          enabled = true;
          sourceUrl = plugins-url;
        };

        unicode-picker = {
          enabled = true;
          sourceUrl = plugins-url;
        };

        polkit-agent = {
          enabled = true;
          sourceUrl = plugins-url;
        };

        niri-overview-launcher = {
          enabled = true;
          sourceUrl = plugins-url;
        };

        privacy-indicator = {
          enabled = true;
          sourceUrl = plugins-url;
        };
      };
    };

    pluginSettings = {};
  };
}
