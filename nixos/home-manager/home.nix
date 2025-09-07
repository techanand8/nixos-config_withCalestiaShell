{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    # ../modules/nvf.nix
    ../modules/yazi
    (../. + "/modules/${"AI&ML"}/${"ai&mlPkgs.nix"}")
    (../. + "/modules/${"DevSecOps&Cloud"}/${"devoudPkgs.nix"}")
  ];

  home.username = "mayank-anand";
  home.homeDirectory = "/home/mayank-anand";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # browser
    microsoft-edge
    google-chrome
    brave
  
    #fetch
    fastfetch
    neofetch
    nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    gemini-cli
    discord
    thunderbird
 
  ];

  home.file.".config/hypr/hyprland.conf".source = "${inputs.caelestia-dots}/hypr/hyprland.conf";
  home.file.".config/hypr/hypridle.conf".source = "${inputs.caelestia-dots}/hypr/hypridle.conf";
  home.file.".config/hypr/scheme".source = "${inputs.caelestia-dots}/hypr/scheme";
  home.file.".config/hypr/scripts".source = "${inputs.caelestia-dots}/hypr/scripts";
  home.file.".config/hypr/hyprland".source = "${inputs.caelestia-dots}/hypr/hyprland";


   home.pointerCursor = {
    name = "Adwaita"; # or another theme
    package = pkgs.adwaita-icon-theme;
    size = 24;
    x11.enable = true;
    gtk.enable = true;
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
