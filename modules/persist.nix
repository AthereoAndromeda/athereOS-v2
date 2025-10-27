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
        "greetd"
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
          "Downloads"
          "Documents"
          "Pictures"
          "Videos"
          "Music"

          ".zen"
          ".gnupg"
          ".ssh"
          ".minecraft"
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
          "Trash"
          "direnv"
        ];

      files = [
        ".config/gnome-initial-setup-done"
      ];
    };
  };
}
