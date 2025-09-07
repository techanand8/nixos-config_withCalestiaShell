{
  description = "NixOS configuration with Caelestia dots and Hyprland";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";

    nixpkgStable = {
      url = "github:nixos/nixpkgs/nixos-25.05";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    app2unit = {
      url = "github:soramanew/app2unit";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      #      url = "github:miliu2cc/caelestia-shell-nixos";
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.app2unit.follows = "app2unit";
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
      #  inputs.app2unit.follows = "app2unit";
    };

    caelestia-dots = {
      url = "path:/etc/nixos/modules/caelestia-dots";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #   nixos-boot = {
    #    url = "github:Melkor333/nixos-boot";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ax-shell = {
      url = "github:Axenide/Ax-Shell";
      flake = false; # Since it's just a config repo
    };

    anipy-cli.url = "github:sdaqo/anipy-cli";
  };

  outputs =
    { self
    , nixpkgs
    , hyprland
    , caelestia-shell
    , caelestia-cli
    , caelestia-dots
    , home-manager
    , quickshell
    , app2unit
    , nixpkgStable
    , spicetify-nix
    , nvf
    , catppuccin
    , #    nixos-boot,
      microvm
    , ax-shell
    , anipy-cli
    , ...
    } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };

        # overlays = [ spicetify-nix.overlays.default];
      };
      _zedPlexMonoPackage = pkgs.callPackage ./modules/zedplexmono.nix { };
    in
    {
      nixosConfigurations.Logic_HuntXPro = nixpkgs.lib.nixosSystem {
        # system = "x86_64-linux";
        inherit system;
        specialArgs = { inherit inputs spicetify-nix nixpkgStable; };
        modules = [
          ./configuration.nix
          ./modules/hyprconfig.nix
          ./modules/spicetify.nix
          ./modules/systemPkgs.nix
          ./modules/optimise.nix
          ./modules/update.nix
          ./modules/flatpak.nix
          ./modules/security/securityPkgs.nix
          ./modules/fonts.nix
          ./modules/zenbrowserpkg.nix
          #./modules/packettracerpkgs.nix
          ./modules/androidPkgs.nix
          ./modules/gnomeExtensions.nix

          {
            environment.systemPackages = [
              anipy-cli.packages.${system}.default
            ];
          }

          spicetify-nix.nixosModules.default
          catppuccin.nixosModules.catppuccin
          #     nixos-boot.nixosModules.default
          microvm.nixosModules.host

          {
            _module.args.spicetify-nix = spicetify-nix;
            _module.args.zedPlexMono = _zedPlexMonoPackage;
          }
          hyprland.nixosModules.default
          ({ pkgs
           , inputs
           , ...
           }: {
            programs.hyprland = {
              enable = true;
              xwayland.enable = true;
              withUWSM = true;
              package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
              portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
            };
            # Ensure Mesa compatibility
            hardware.graphics = {
              package = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa;
              enable32Bit = true;
              package32 = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.pkgsi686Linux.mesa;
            };
          })

          home-manager.nixosModules.home-manager
          #  nvf.homeManagerModules.default
          ({ config, ... }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.mayank-anand = import ./home-manager/home.nix { inherit inputs pkgs system; };
            home-manager.extraSpecialArgs = {
              nvfInput = inputs.nvf;
              zedPlexMono = config.zedPlexMono;
            };
          })
          # Include caelestia-dots configurations if they provide a Nix module
          # (import "${caelestia-dots}./modules/hyprconfig.nix" { inherit pkgs; })
        ];
      };
    };
}
