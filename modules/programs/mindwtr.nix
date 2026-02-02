{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  wrapGAppsHook3,
  makeWrapper,
  alsa-lib,
  gtk3,
  webkitgtk_4_1,
  libayatana-appindicator,
}:
stdenv.mkDerivation rec {
  pname = "mindwtr";
  version = "0.6.5";

  src = fetchurl {
    url = "https://github.com/dongdongbh/Mindwtr/releases/download/v${version}/Mindwtr_${version}_amd64.deb";
    hash = "sha256-8HC3R4NLvg59wMA1wB6Wv6fzhJ2ARQfg2LNdWnw18Qg=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    wrapGAppsHook3
    makeWrapper
  ];

  buildInputs = [
    alsa-lib
    gtk3
    webkitgtk_4_1
    libayatana-appindicator
  ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    mkdir -p $out/bin $out/share
    cp -r usr/bin/* $out/bin/
    cp -r usr/share/* $out/share/
  '';

  postFixup = ''
    wrapProgram $out/bin/mindwtr \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [libayatana-appindicator]}"
  '';

  meta = with lib; {
    description = "A complete Getting Things Done (GTD) productivity system";
    homepage = "https://github.com/dongdongbh/Mindwtr";
    license = licenses.agpl3Only;
    platforms = ["x86_64-linux"];
    mainProgram = "mindwtr";
  };
}
