{ lib
, stdenv
, fetchurl
, autoPatchelfHook
, makeWrapper
, alsa-lib
, fontconfig
, freetype
, zlib
, libX11
, libXext
, libXi
, libXrender
, libXtst
, libXxf86vm
, cups
, gtk3
, atk
, pango
, cairo
, gdk-pixbuf
, libGL
}:

let
  rtDeps = [
    stdenv.cc.cc.lib
    alsa-lib
    fontconfig
    freetype
    zlib
    libX11
    libXext
    libXi
    libXrender
    libXtst
    libXxf86vm
    cups
    gtk3
    atk
    pango
    cairo
    gdk-pixbuf
    libGL
  ];
in
stdenv.mkDerivation rec {
  pname = "bellsoft-jdk";
  version = "25.0.4.1+1";

  src = fetchurl {
    url = "https://download.bell-sw.com/java/${version}/bellsoft-jdk${version}-linux-amd64-full.tar.gz";
    sha256 = "sha256-dN5phjz6jVjdSZkqlySa0EEWmtAdqhSlRe+cfvFzy9A=";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];
  buildInputs = rtDeps;

  autoPatchelfIgnoreMissingDeps = [
    "libavcodec-ffmpeg.so.56"
    "libavformat-ffmpeg.so.56"
    "libavcodec.so.54"
    "libavformat.so.54"
    "libavcodec.so.56"
    "libavformat.so.56"
    "libavcodec.so.57"
    "libavformat.so.57"
    "libavcodec.so.58"
    "libavformat.so.58"
    "libavcodec.so.59"
    "libavformat.so.59"
    "libavcodec.so.60"
    "libavformat.so.60"
    "libavcodec.so.61"
    "libavformat.so.61"
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r ./* $out/
    runHook postInstall
  '';

  dontConfigure = true;
  dontBuild = true;

  postFixup = ''
    for bin in $out/bin/*; do
      if [ -f "$bin" ] && [ -x "$bin" ]; then
        wrapProgram "$bin" \
          --prefix LD_LIBRARY_PATH : "$out/lib:${lib.makeLibraryPath rtDeps}"
      fi
    done
  '';

  meta = with lib; {
    description = "BellSoft Liberica JDK (prebuilt, full bundle with JavaFX)";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
}
