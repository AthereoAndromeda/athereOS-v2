inputs: custom-utils: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";

    # Users
    users = {
      athereo = import ./athereo.nix;
    };

    extraSpecialArgs = {
      inherit inputs custom-utils;
    };
  };
}
