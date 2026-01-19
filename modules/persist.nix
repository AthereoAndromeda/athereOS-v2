{...}: let
  inherit (builtins) map;
in {
  environment.persistence."/persist" = {
    hideMounts = true;
    directories =
      []
      ++
      # /var/lib dirs
      map (x: "/var/lib/" + x) [
        "nixos"
        "vaultwarden"
        "bluetooth"
        "cups"
        "greetd"
        "regreet"
      ]
      ++
      # /etc dirs
      map (x: "/etc/" + x) [
        "nixos"
        "NetworkManager"
        "greetd"
      ];

    files =
      [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ]
      ++
      # SSL Certificates
      map (x: "/etc/ssl/certs/" + x) [
        "upd_dilnet.crt"
        "upd_eduroam.crt"
      ];

    users.athereo = {
      directories =
        [
          {
            directory = "athereOS-v2";
            mode = "0755";
          }
          {
            directory = ".config/obsidian";
            mode = "0755";
          }
          {
            directory = ".local/share/Trash";
            mode = "1777";
          }
          "Downloads"
          "Documents"
          "Pictures"
          "Videos"
          "Music"

          ".julia"
          ".zen"
          ".thunderbird"
          ".gnupg"
          ".ssh"
          ".minecraft"
          ".cargo"
        ]
        ++
        # Config dirs
        map (x: ".config/" + x) [
          "kryptor"
          "age"
          "vesktop"
          "direnv"
        ]
        ++
        # .local/share dirs
        map (x: ".local/share/" + x) [
          "zoxide"
          "navi"
          "keyrings"
          "direnv"
        ];

      files = [
        ".config/gnome-initial-setup-done"
      ];
    };
  };
}
