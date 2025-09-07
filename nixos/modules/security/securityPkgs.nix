{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    burpsuite
    wireshark
    # nmap
    zmap
    # Static Analysis
    jadx # Dex to Java decompiler
    apktool # APK decompiler
    bytecode-viewer
    dex2jar # APK to JAR converter
    # Network Analysis
    #mitmproxy
    tcpdump
    # Dynamic Analysis

    frida-tools
    # Reverse Engineering
    radare2
    ghidra
    cutter
    # Utility Tools
    #jq
    xxd
    binwalk
    sqlite
    openssl
    #nmap
    metasploit

    #sandbox
    firejail
    bubblewrap

    amass
  ];

   networking.firewall.enable = true;          # Enable firewall
   
    networking.wireguard.interfaces.wg0 = {
    ips = [ "10.0.0.2/24" ];
    privateKeyFile = "/etc/wireguard/privatekey";
    
    peers = [
      {
        publicKey = "A2X3gnA1vcaGx8NrxvyRsjGdLmQgk3X7dRlyf1qJ6jQ=";
        allowedIPs = [ "0.0.0.0/0" ];  # Route all traffic through VPN
        endpoint = "169.150.196.95:51820";
        persistentKeepalive = 25;
      }
    ];
  };

  # Optional: Set up the private key file securely
  environment.etc."wireguard/privatekey" = {
    mode = "0400";  # Read-only for root
    text = "aMAAcmYhhjjUT7ZmTbETeTPu2e2pE+ljpBvdLZsBUEI=";  # Or use a secrets manager
  };

   # Add proper dependencies to ensure DNS works first
  systemd.services.wireguard-wg0 = {
    after = [ "network.target" "network-online.target" "nss-lookup.target" ];
    wants = [ "network-online.target" ];
  };
# Ensure DNS is overridden
networking.networkmanager.dns = "systemd-resolved";
services.resolved.enable = true;
  # Optional: Ensure WireGuard starts after network is available
 # systemd.services.wireguard-wg0.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];

}
