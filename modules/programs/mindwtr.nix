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
  version = "1.0.0";

  src = fetchurl {
    url = "https://github.com/dongdongbh/Mindwtr/releases/download/v${version}/Mindwtr_${version}_amd64.deb";
    hash = "sha256-TV7MSt47ZLziWeXt5tv/tn+CrQcBgxd5qRSJv1MBJ0M=";
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
