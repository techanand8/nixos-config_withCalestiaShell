{ lib
, stdenv
, autoPatchelfHook
, fetchurl
, makeWrapper
, glib
, gtk3
, libsecret
, nss
, xorg
, alsa-lib
}:

stdenv.mkDerivation rec {
  pname = "zenbrowser";
  version = "latest";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz";
    sha256 = "VuGSsTTPMfMJesABIh2WDRD3IO6UxJmstqImCl7iRzE=";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];
  buildInputs = [ glib gtk3 libsecret nss xorg.libX11 xorg.libXext xorg.libXdamage alsa-lib ];

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin $out/share/zenbrowser
    tar -xf $src -C $out/share/zenbrowser --strip-components=1
    chmod +x $out/share/zenbrowser/zen

    makeWrapper $out/share/zenbrowser/zen $out/bin/zenbrowser \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}" \
      --prefix PATH : "${lib.makeBinPath [ gtk3 ]}"

    mkdir -p $out/share/applications
    cat > $out/share/applications/zenbrowser.desktop <<EOF
    [Desktop Entry]
    Name=Zen Browser
    Exec=zenbrowser
    Comment=A privacy-focused web browser
    Terminal=false
    Type=Application
    Categories=Network;WebBrowser;
    EOF

    if [ -f $out/share/zenbrowser/zen.png ]; then
      mkdir -p $out/share/icons/hicolor/256x256/apps
      cp $out/share/zenbrowser/zen.png $out/share/icons/hicolor/256x256/apps/zenbrowser.png
      sed -i 's|^Icon=.*|Icon=zenbrowser|' $out/share/applications/zenbrowser.desktop
    fi
  '';

  meta = with lib; {
    description = "Zen Browser - A privacy-focused web browser";
    homepage = "https://zen-browser.app";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}

