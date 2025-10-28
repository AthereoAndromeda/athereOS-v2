{...}: {
  sops.validateSopsFiles = false;
  sops.defaultSopsFile = "/home/athereo/athereOS-v2/secrets/example.yaml";
  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  sops.age.keyFile = "/home/athereo/.config/sops/age/keys.txt";

  sops.secrets = {
    hello = {};
    example_key = {};
    lol = {};
  };
}
