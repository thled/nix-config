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
  version = "v1.2.0";

  src = fetchFromGitHub {
    owner = "thled";
    repo = pname;
    rev = version;
    sha256 = "sha256-SDMz4XZueLn3dUuJaczefFfkXNYGQCN2KFu3p78pHR4=";
  };

  cargoSha256 = "sha256-ctfYylK5Ean6TJTOKhNxxG8UEMCvEti8ZjbVGO9ke08=";

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
