{ config, pkgs, ... }:

{
  environment.systemPackages = [
       (import ./packettracer.nix {                             
       inherit pkgs;                                          
       inherit (pkgs) lib stdenv autoPatchelfHook makeWrapper;                                                   
     })
 ];

  # Desktop integration (optional)
  environment.etc."xdg/autostart/packettracer.desktop".text = ''
    [Desktop Entry]
    Name=Packet Tracer
    Exec=${pkgs.bash}/bin/bash -c "QT_QPA_PLATFORM=xcb /opt/pt/packettracer"
    Icon=/opt/pt/art/app.png
    Type=Application
    Categories=Network;
  '';
}
