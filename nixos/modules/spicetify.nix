{ pkgs, lib, spicetify-nix, ... }:

let
  #spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
    spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
  # Convert local path to a Nix store path
  localCaelestiaTheme = builtins.path {
    path = ./spicetify/Themes/caelestia;
    name = "caelestia-theme";
  };
in {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["spotify"];

  programs.spicetify = {
    enable = true;

    theme = {
      name = "caelestia";
      src = localCaelestiaTheme;  # Now a proper Nix store path
      injectCss = true;
      replaceColors = false;
      overwriteAssets = false;
    };

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
    ];
  };
}

