{ config
, pkgs
, lib
, nixpkgStable
, ...
}: {
  environment.systemPackages = with pkgs; [
    # Build systems
    cmake
    gnumake

    # Debugging
    gdb
    valgrind

    #c/c++
    gcc15
    gcc
    libgcc
    clang
    llvm

    #java(jdk)
    openjdk24
    #jdk24
    zulu24
    #python
    python3Full
    python-launcher
    python313Packages.pip
    pipx
    gtk2
    opencv
    pkg-config
    uv
    pipenv
    python313Packages.tkinter
    python313Packages.distutils
    python313Packages.streamlit
    python313Packages.transformers

    # Rust
    rustc
    cargo

    # JavaScript
    nodejs
    yarn

    # Go
    go

    #Rust
    rustc
    rustup
    #sql
    sqlite
    postgresql
    dbeaver-bin #gui
    # beekeeper-studio
    #mariadb
    mariadb_118
    mycli
    mysql84
    # mysql-workbench
    mariadb-embedded
    mysql-shell



    # CLI utilities
    #htop
    tree
    #unzip
    zip
    #wget
    #curl

    # Linting & formatting
    # shellcheck

    #editor
    #neovim
    gedit

    #daily use
    #lsd
    eza
    #btop
    bat
    #curl
    #wget
    #zoxide

    #shell
    #fish
    nushell
    nu_scripts
    # Official plugins
    nushellPlugins.query
    nushellPlugins.gstat
    nushellPlugins.formats
    nushellPlugins.hcl
    nushellPlugins.units
    nushellPlugins.semver
    nushellPlugins.polars
    nushellPlugins.highlight
    nufmt

    skim
    navi
    atuin
    bottom
    lazygit
    gh
    procs
    du-dust

    # Editor support
    vscode-extensions.thenuprojectcontributors.vscode-nushell-lang

    #fetch
    # fastfetch (home-manager)
    nerdfetch

    # Assembly
    nasm
    binutils

    # Bash & Scripting
    shellcheck
    shfmt

    #terminal
    # ghostty wezterm alacritty kitty (home-manager)
    wezterm

    ripgrep # Enhance the teaching experience grep and telescope
    #xclip # or clipcat

    #wl-clipboard

    #notes making apps
    obsidian
    appflowy

    #media
    mpv
    mpd
    telegram-desktop
    # discord (home-manager)

    # fuzzy finder
    #fzf
    fd
    fzf-zsh
    fzf-make

    #starship config
    starship

    oh-my-posh
    #yazi
    chafa
    #ranger
    lf
    ffmpeg
    vlc
    imagemagick
    p7zip
    #  hyprcursor (in hyprland.nix)
    #hyprland
    ueberzug
    pistol
    oh-my-zsh
    python313Packages.image-go-nord
    astroterm
    findutils
    rtkit
    xsel
    unrar
    # gemini-cli ( in home-manager)

    just
    catppuccin-whiskers
    rofi-emoji
    youtube-music
    yt-dlp
    ytmdl
    mov-cli
    niriswitcher
    ryzenadj

    #office
    libreoffice-fresh
    onlyoffice-desktopeditors
    fff
    ascii-image-converter
    neofetch
    cpufetch
    screenfetch
    xfce.mousepad
    # music
    spotify

    #language model
    ollama
    ollama-rocm
    #open-interpreter
    aichat
    python313Packages.litellm
    litellm

    eww
    wireplumber # PipeWire volume control

    #tor
    tor
    tor-browser
    torsocks
    tor-browser-bundle-bin

    nasm # Netwide Assembler (x86/x64)
    binutils # GNU assembler (gas)
    llvmPackages.bintools # LLVM assembler tools

    # Debuggers
    gdb # GNU debugger
    lldb
    assemblyscript
    rappel
    asmrepl
    asm-lsp
    armitage
    armips
    armadillo
    kanata
    kanata-with-cmd
    #    caligula #user-friendly disk imaging
    figlet
    toilet
    lolcat
    boxes
    cowsay
    kdePackages.plasma-nm
    networkmanagerapplet
    protonvpn-gui
    protonvpn-cli
    ueberzugpp
    #openvpn
    openvpn
    #openvpn3
    ghostscript
    #powershell
    powershell
    steam-run
    breeze-hacked-cursor-theme
    #tiling
    niri

    #Files database for nixpkgs
    nix-index
    #web interface
    nix-web
    #Rust tool to monitor Nix processes
    nix-btm
    #App source + Nix packages + Docker = Image Resources
    nixpacks

    nixos-icons
    #flashcards
    #anki
    tmux
    #screenshot
    flameshot
    satty
    #browse the fediverse
    tuba

    #nix language server
    nil
    nixd
    #nix code formatter
    nixpkgs-fmt
    #llm
    lmstudio
    #virtualmachine
    virt-manager
    virt-viewer
    qemu
    gnome-boxes

    fuse
    gtkmm3
    libdnet
    kardolus-chatgpt-cli
    chatgpt-cli
    github-desktop
    gnome-remote-desktop
    remmina
    freerdp
    stdenv.cc.cc.lib
    slurp
    grim
    v4l2-relayd
    g-ls
    rustpython

    amazon-q-cli

    wireguard-ui
    wireguard-tools
    wg-netmanager
    wireguard-go
    wireguard-vanity-keygen
    kando

     linux-firmware
    bluez
    bluez-tools
    amdgpu_top

    arduino
    arduino-cli
    arduino-core
     arduino-ci
    arduino-ide
    arduino-create-agent
    arduino-language-server
    streamlit

    #vlsi
    magic-vlsi
    alliance
    iverilog
    vhd2vl
     vhdl-ls
     nvc
     gtkwave
     openroad
     verilator
     yosys
     #embedded
     gcc-arm-embedded
      openocd
      stm32flash
      stm32loader

    ngspice
    xschem
    #nextpnr
    #nextpnrWithGui
    icestorm
    arachne-pnr



  ];

  security.auditd.enable = true; # system activity logging
  security.apparmor.enable = true; # extra process isolation

  # Load the upstream AppArmor profiles from nixpkgs
  security.apparmor.policies = {
    community = {
      path = "${pkgs.apparmor-profiles}/etc/apparmor.d";
    };
  };

  # Enable AppArmor in the kernel
  boot.kernelParams = [ "lsm=landlock,lockdown,yama,apparmor,bpf" ];

  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;


  # Enable WireGuard support
  networking.wireguard.enable = true;

  services.xrdp.enable = true;

  # Enable KVM for QEMU and other accelerations
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "mayank-anand" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  # Podman (alternative container runtime)
  virtualisation.podman.enable = true;

  # LXC/LXD containers
  virtualisation.lxd.enable = true;

  # VirtualBox configuration
  # virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;
  #users.extraGroups.vboxusers.members = [ "mayank-anand" ];

  users.users.mayank-anand.extraGroups = [
    "libvirtd"
    "vmware"
    "audio"
    "video"
  ];
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  virtualisation.vmware.host = {
    enable = true;
    #  package = pkgs.vmware-workstation;  # or player
  };
  #  boot.extraModulePackages = with config.boot.kernelPackages; 
  # lib.optional (!config.virtualisation.vmware.host.enable) virtualbox;

  # Required kernel modules
  boot.extraModulePackages = with config.boot.kernelPackages; [
    vmware
  ];
  boot.kernelModules = [ "vmw_vmci" "vmmon" "vmnet" ];



  virtualisation.docker.enable = true;


  services.geoclue2.enable = true;
  services.gvfs.enable = true;

  services.mysql = {
    enable = true;
    package = pkgs.mysql84;
  };
  services.postgresql.enable = true;
  # services.postgresql.enableTCPIP = true; # Optional: Enable remote connections
  #services.tor.enable = true;
  programs.pay-respects.enable = true;
  programs.command-not-found.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  boot.initrd.kernelModules = [ "amdgpu" ];

  services.fwupd.enable = true; # For firmware updates

  #To reduce information leakage from kernel logs and pointers.
  boot.kernel.sysctl."kernel.kptr_restrict" = 1;
  boot.kernel.sysctl."kernel.dmesg_restrict" = 1;

  hardware.enableRedistributableFirmware = true;
    # Enable Linux firmware
  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  # boot.kernelParams = [
  # For Barcelo APUs, these are more relevant:
  #  "amdgpu.dc=1" # Enable Display Core (required for most AMD GPUs)
  # "amdgpu.sg_display=0" # Only if you still see display issues
  # "radeon.si_support=0" # Force AMDGPU driver
  # "amdgpu.si_support=1"
  #];

  #hardware.graphics = {
  # enable = true; # Enables graphics stack (OpenGL, Vulkan, etc.)
  # enable32Bit = true; # Enables 32-bit support for e.g. Steam, Wine
  # extraPackages = with pkgs; [
  #   amdvlk
  #   mesa # OpenGL/Vulkan drivers
  #   vulkan-loader
  #   libva # Video acceleration
  # ];
  # extraPackages32 = with pkgs; [
  #   driversi686Linux.amdvlk
  # ];
  #};

  environment.variables = {
    AMD_VULKAN_ICD = "RADV"; # Use Mesa's Vulkan driver instead of AMDVLK
    RADV_PERFTEST = "gpl"; # Enable advanced features
    #here key
  };

  # security.sudo.extraConfig = ''
  # Defaults env_keep += "PROMPT"
  #  Defaults env_keep += "PS1"
  #'';

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

  #  nixos-boot = {
  # enable = true;

  # Set background color to pure black
  #bgColor.red = 0;
  #bgColor.green = 0;
  # bgColor.blue = 0;

  # Optional: show the theme for a few seconds in fast boots
  #   duration = 3.0;
  # };

  # configuration.nix
  #services.tor = {
    #enable = true;
    #openFirewall = true;

    #client.enable = true;
    #torsocks.enable = true;

    #settings = {
      #SocksPort = "9050 IsolateDestAddr IsolateDestPort";
      #AutomapHostsOnResolve = true;
      #DNSPort = 9053;
      #ControlPort = 9051;

      #Nickname = "MyUniqueRelay";
     # ContactInfo = "myemail@example.com";
    #  SafeLogging = 1;
   # };
  #};
  services.tor = {
  enable = true;
  openFirewall = true;

  client.enable = true;   # Use Tor as client
  torsocks.enable = true; # Wrap programs with torsocks

  settings = {
    SocksPort = "9050 IsolateDestAddr IsolateDestPort"; # Local SOCKS proxy
    AutomapHostsOnResolve = true;
    DNSPort = 9053;   # DNS via Tor
    ControlPort = 9051;
    CookieAuthentication = true;  # Add authentication
    SafeLogging = 1;
  };
};


}
