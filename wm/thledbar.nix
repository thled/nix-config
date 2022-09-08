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
  version = "v1.1.1";

  src = fetchFromGitHub {
    owner = "thled";
    repo = pname;
    rev = version;
    sha256 = "nlgQi0/eWKu7oC3KcV++ExrVcgA3H8Au/vWayzNH1L0=";
  };

  cargoSha256 = "wJyFuBtCNrx3W6OS4TSu3SR4Ffo806jJzXSoNGgTv/s=";

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
