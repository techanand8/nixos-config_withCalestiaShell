{ pkgs, lib, stdenv, autoPatchelfHook, makeWrapper }:

stdenv.mkDerivation rec {
  pname = "packet-tracer";
  version = "8.2.2";

  src = /opt/pt;  # Reference the installed location

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];

  installPhase = ''
    mkdir -p $out/opt/pt
    cp -r $src/* $out/opt/pt/
    
    # Fix permissions on the binary
    chmod +x $out/opt/pt/packettracer
    
    # Create wrapper with required libraries
    makeWrapper $out/opt/pt/packettracer $out/bin/packettracer \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath (with pkgs; [
        libGL
        xorg.libxcb
        qt5.qtbase
        qt5.qtwebengine
        zlib
        libpulseaudio
        openssl
        xorg.libX11
        xorg.libXext
        xorg.libXrender
      ])}" \
      --prefix PATH : "${lib.makeBinPath [ pkgs.xorg.xrandr ]}" \
      --set QT_QPA_PLATFORM xcb
  '';

  meta = with lib; {
    description = "Cisco Packet Tracer Network Simulator";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}
