{
  config,
  pkgs,
  lib,
  zedPlexMono,
  ...
}:
# ----=[ Fonts Configuration for NixOS ]=---- #
let
  #  _zedplexmono_package = pkgs.callPackage ./zedplexmono.nix {};
in {
  # Define zedPlexMono as a formal NixOS option
  config = {
    fonts = {
      enableDefaultPackages = true; # Ensures core fonts are available

      # List your preferred fonts here
      packages =
        [
          zedPlexMono # ← my custom font!
        ]
        ++ (with pkgs; [
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-emoji
          liberation_ttf
          fira-code
          fira-code-symbols
          ubuntu_font_family
          vazir-fonts # Example: Persian font

          #nerd-fonts._0xproto
          #nerd-fonts.droid-sans-mono
          nerd-fonts.fira-code
          nerd-fonts._0xproto
          nerd-fonts.droid-sans-mono
          nerd-fonts.caskaydia-cove
          nerd-fonts.ubuntu
          ubuntu-sans
          jetbrains-mono
          ibm-plex
          nerd-fonts.zed-mono

          # Add more fonts as needed
        ]);

      # Make fonts visible to Flatpak and other sandboxed apps
      fontDir.enable = true;

      # Set default fonts for different languages and styles
      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = ["Zed Plex Mono" "Liberation Serif" "Vazirmatn"];
          sansSerif = ["Zed Plex Mono" "Ubuntu" "Vazirmatn"];
          monospace = ["Zed Plex Mono" "FiraCode Nerd Font Mono" "FiraCode Nerd Font" "Ubuntu Mono" " Jetbrains-mono"];
          emoji = ["Noto Color Emoji"];
        };
        useEmbeddedBitmaps = true; # Better emoji rendering in apps like Firefox
        # Example: custom font substitution
        localConf = ''
          <match target="pattern">
            <test qual="any" name="family"><string>NewCenturySchlbk</string></test>
            <edit name="family" mode="assign" binding="same"><string>TeX Gyre Schola</string></edit>
          </match>
        '';
      };
    };
  };
}
