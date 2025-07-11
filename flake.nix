{
  description = "NixOS Flake for my Laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Home-manager uses system nixpkgs (home-manager.useGlobalPackages = true)
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Blows up root on boot
    impermanence.url = "github:nix-community/impermanence";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minegrub-theme.url = "github:Lxtharia/minegrub-theme";

    xremap.url = "github:xremap/nix-flake";
    xremap.inputs.nixpkgs.follows = "nixpkgs";

    xdg-termfilepickers.url = "github:guekka/xdg-desktop-portal-termfilepickers";
    xdg-termfilepickers.inputs.nixpkgs.follows = "nixpkgs";

    legacy-launcher.url = "github:AthereoAndromeda/legacy-launcher-nix";
    legacy-launcher.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      config.allowUnfreePredicate = pkg: true;
      # overlays = []; # WARN: This does not appear to work with home-manager
    };

    custom-utils = import ./utils {inherit lib;};
    custom-modules = import ./modules {inherit nixpkgs pkgs inputs custom-utils;};
    inherit (custom-modules) grub-themes;
  in {
    nixosConfigurations = {
      athereo-lenovo-nixos = lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs grub-themes custom-utils;
        };

        modules = [
          inputs.xdg-termfilepickers.nixosModules.default

          # Configure Nix/pkgs
          {
            nixpkgs.overlays = [
              inputs.legacy-launcher.overlays.legacy-launcher
            ];
            nix.settings.experimental-features = ["nix-command" "flakes"];
          }

          # Setup nixos-hardware
          inputs.nixos-hardware.nixosModules.lenovo-ideapad-16ahp9

          # Setup impermanence
          inputs.impermanence.nixosModules.impermanence
          # Setup persistent storage
          custom-modules.persist

          # Add custom overlays
          custom-modules.overlays

          # Setup xremap
          inputs.xremap.nixosModules.default

          # Setup home-manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.athereo = import ./profiles/athereo.nix;

            home-manager.extraSpecialArgs = {
              inherit inputs custom-utils; # Don't pass NixOS lib, home-manager provides its own
            };
          }

          # Add MineGrub Theme
          inputs.minegrub-theme.nixosModules.default

          # Entrypoint
          ./nixos
        ];
      };
    };
  };
}
