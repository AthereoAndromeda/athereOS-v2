{
  description = "NixOS Flake for my Laptop";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Home-manager uses system nixpkgs (home-manager.useGlobalPackages = true)
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs {inherit system;};

    custom-modules = import ./modules {inherit nixpkgs pkgs inputs;};
    inherit (custom-modules) grub-themes;

    custom-utils = import ./utils/read-nix-recursive.nix lib;
  in {
    nixosConfigurations = {
      athereo-lenovo-nixos = lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs grub-themes custom-utils;
        };

        modules = [
          inputs.xdg-termfilepickers.nixosModules.default

          # Setup Lix
          inputs.lix-module.nixosModules.default

          # Configure Nix/pkgs
          {
            nixpkgs.config.allowUnfree = true;
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
              inherit inputs; # Don't pass NixOS lib, home-manager provides its own
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
