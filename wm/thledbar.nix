{
  alsaLib,
  cairo,
  cargo,
  fetchFromGitHub,
  glib,
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
  version = "v1.3.1";

  src = fetchFromGitHub {
    owner = "thled";
    repo = pname;
    rev = version;
    sha256 = "sha256-0yqhHM/YXSoKWpQ2rRXvPTkJ4m1hPn1z0ASNvKpEjsU=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "cnx-0.3.0" = "sha256-FZersujU/nNrSjUkyqD4MqZvnHxpkNa+0vl7tRYNPgc=";
    };
  };

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

  meta = {
    description = "My configuration of the Cnx status bar";
    homepage = "https://github.com/thled/thledbar";
  };
}
