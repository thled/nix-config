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
  version = "v1.2.1";

  src = fetchFromGitHub {
    owner = "thled";
    repo = pname;
    rev = version;
    sha256 = "sha256-u2y52NxkflhL3xgP7rM33AqjXVEwlZCLEaOh9ylXz3A=";
  };

  cargoSha256 = "sha256-wSx9aIyMaNTqMrLARuqICh4DcmYAkQXrcntMJD52dgg=";

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
