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

    mango.url = "github:DreamMaoMao/mango";
    mango.inputs.nixpkgs.follows = "nixpkgs";

    jsonc2json-bin.url = "github:AthereoAndromeda/jsonc-to-json";
    jsonc2json-bin.inputs.nixpkgs.follows = "nixpkgs";

    nuenv.url = "github:DeterminateSystems/nuenv";
    nuenv.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
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

          # Add mango nixos module
          inputs.mango.nixosModules.mango

          # Configure Nix/pkgs
          {
            nixpkgs.overlays = [
              inputs.legacy-launcher.overlays.legacy-launcher
              inputs.nuenv.overlays.default
            ];

            # Allow a select number of unfree pkgs
            nixpkgs.config.allowUnfreePredicate = pkg:
              builtins.elem (lib.getName pkg) [
                "obsidian"
              ];

            nix.settings.experimental-features = ["nix-command" "flakes"];
          }

          # Setup nixos-hardware
          inputs.nixos-hardware.nixosModules.lenovo-ideapad-16ahp9

          # Setup impermanence and persistent storage
          inputs.impermanence.nixosModules.impermanence
          custom-modules.persist

          # Add custom overlays
          custom-modules.overlays

          # Setup xremap
          inputs.xremap.nixosModules.default

          # Setup home-manager
          home-manager.nixosModules.home-manager
          (import ./profiles/home-manager.nix inputs custom-utils)

          # Add MineGrub Theme
          inputs.minegrub-theme.nixosModules.default

          # Entrypoint
          ./nixos
        ];
      };
    };
  };
}
