{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable XDG portals for Wayland
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk];
  };
  environment.systemPackages = with pkgs; [
    inputs.caelestia-shell.packages.${pkgs.system}.caelestia-shell
    inputs.caelestia-shell.packages.${pkgs.system}.default
    inputs.caelestia-cli.packages.${pkgs.system}.default
    inputs.caelestia-cli.packages.${pkgs.system}.caelestia-cli
    material-symbols
    jetbrains-mono
    xfce.thunar
    rofi-wayland
    waybar
    neovim
    vim-full
    kitty
    wl-clipboard
    xclip
    zoxide
    lsd
    foot
    ghostty
    banana-cursor
    material-cursors
    bibata-cursors
    inputs.app2unit.packages.${pkgs.system}.app2unit
    inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell
    yazi
    starship
    fuzzel
    hyprpaper
    zed-editor
    cliphist
    vscode
    vscodium
    spicetify-cli
    htop
    #wlsunset
    gammastep
    geoclue2
    geoclue2-with-demo-agent
    wlsunset
    hyprlandPlugins.hyprgrass
  ];
  
  # Enable fonts
  fonts.packages = with pkgs; [
    font-awesome
    jetbrains-mono
    nerd-fonts.jetbrains-mono
  ];

  environment.variables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  environment.sessionVariables = {
    #   NIXOS_OZONE_WL = "1";

    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CAELESTIA_BD_PATH = "${inputs.caelestia-shell.packages.${pkgs.system}.default}/bin/beat_detector";

    GTK_CURSOR_THEME_NAME = "Adwaita";
    GTK_CURSOR_THEME_SIZE = "24";
  };
  services.gnome.gnome-keyring.enable = true;
  programs.zsh.enable = true;
  # Optional: Enable fish shell for Caelestia CLI
  programs.fish.enable = true;
  users.users.mayank-anand.shell = pkgs.fish;

  system.activationScripts.caelestia-dots = "
  mkdir -p /etc/caelestia
  cp -r ${inputs.caelestia-dots}/* /etc/caelestia/
  chmod -R +w /etc/caelestia
  ";
}
