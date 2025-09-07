{
  description = "ZaneyOS with Logic_HuntXPro, Home Manager as NixOS module, Stylix, nix-flatpak, and more";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; # Use the same nixpkgs source
    };

    stylix.url = "github:danth/stylix";
    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
    #nix-flatpak.inputs.nixpkgs.follows = "nixpkgs";
    hyprsysteminfo.url = "github:hyprwm/hyprsysteminfo";
    hyprsysteminfo.inputs.nixpkgs.follows = "nixpkgs";
    nixd = {
      url = "github:nix-community/nixd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # QuickShell
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixai = {
      url = "github:olafkfreund/nix-ai-help";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    app2unit = {
      url = "github:soramanew/app2unit";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.app2unit.follows = "app2unit";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
      inputs.app2unit.follows = "app2unit";
      inputs.caelestia-cli.follows = "caelestia-cli";
    };

    #     quickshell = {
    #     url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    #    inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    nvf,
    nix-flatpak,
    hyprsysteminfo,
    nixpkgs-stable,
    quickshell,
    nixd,
    nixai,
    nixvim,
    caelestia-shell,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    username = "mayank-anand";
    hostname = "Logic_HuntXPro";
    profile = "amd";
    host = "Logic_HuntXPro";

    # Define pkgs here
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    stablePkgs = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };

    # pkgs = import nixpkgs { inherit system; };

    # Load variables once
    vars = import ./hosts/${host}/variables.nix;
    _zedPlexMonoPackage = pkgs.callPackage ./modules/zedplexmono.nix {};
  in {
    nixosConfigurations = {
      Logic_HuntXPro = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs username hostname profile host stablePkgs vars;
          zedPlexMono = _zedPlexMonoPackage;
        };
        modules = [
          ./configuration.nix
          ./profiles/amd
          ./systemPkgs.nix
          ./modules/fonts.nix
          ./optimise.nix
          ./update.nix
          ./security.nix

          ({
            config,
            pkgs,
            ...
          }: {
            environment.systemPackages = with pkgs; [
              inputs.nixai.packages.${system}.nixai
            ];
            #  programs.nixvim = {
            #enable = true;

            #colorschemes.catppuccin.enable = true;
            #plugins.lualine.enable = true;
            # };
          })

          ({pkgs, ...}: {
            nix.package = pkgs.nixVersions.latest;
          })
          inputs.nix-flatpak.nixosModules.nix-flatpak
          inputs.nixvim.nixosModules.nixvim
          home-manager.nixosModules.home-manager
          ({
            config,
            lib,
            ...
          }: {
            home-manager = {
              backupFileExtension = "backup";
              # Pass the variables to all Home Manager modules
              extraSpecialArgs = {
                inherit stablePkgs host profile username hostname vars;
                nvfInput = inputs.nvf; # Pass nvf input specifically
                stylixInput = inputs.stylix; # Pass stylix input specifically
                nixvimInput = inputs.nixvim; # Pass nixvim input specifically
                zedPlexMono = config.zedPlexMono;
                caelestia-shell = inputs.caelestia-shell.packages.${system}.default;
              };
              users.${username} = import ./home-manager/home.nix;
            };
          })
        ];
      };
    };
  };
}
