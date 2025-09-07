{ lib, stdenvNoCC }:

stdenvNoCC.mkDerivation {
  pname = "zedplexmono";
  version = "1.0.0";
  src = ../fonts/zed-plex;  # Correct relative path from /etc/nixos/modules

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp *.ttf $out/share/fonts/truetype/
  '';

  meta = with lib; {
    description = "Zed Plex Mono custom font family";
    homepage = "https://github.com/zed-industries/zed-fonts";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}

