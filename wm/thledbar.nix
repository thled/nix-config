{
  alsaLib,
  cairo,
  cargo,
  fetchFromGitHub,
  glib,
  lib,
  openssl,
  pango,
  pkg-config,
  python3,
  rustPlatform,
  rustc,
  xorg,
}:

rustPlatform.buildRustPackage rec {
  pname = "thledbar";
  version = "v1.1.0";

  src = fetchFromGitHub {
    owner = "thled";
    repo = pname;
    rev = version;
    sha256 = "ep30wY55TB+1HcaHUPmIAmQIHt6caCkyKsem8dZ/DEY=";
  };

  cargoSha256 = "EA42Qa/olyA9GNiGQkQ1VdLSy/FAtROa1WDY1+8ea34=";

  nativeBuildInputs = [ 
    pkg-config
    python3
  ];
  buildInputs = [
    alsaLib
    cairo
    cargo
    glib
    openssl
    pango
    rustc
    xorg.libxcb
    xorg.xcbutilwm
  ];

  meta = with lib; {
    description = "My configuration of the Cnx status bar";
    homepage = "https://github.com/thled/thledbar";
  };
}
