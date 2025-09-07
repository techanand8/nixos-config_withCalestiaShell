{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    (callPackage ../modules/zenbrowser.nix {})
  ];
}
