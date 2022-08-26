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
  version = "v1.0.0";

  src = fetchFromGitHub {
    owner = "thled";
    repo = pname;
    rev = version;
    sha256 = "oB/6zGLEippIPLiX7o2BxA74k2rXgMJKcs3unMsNAZw=";
  };

  cargoSha256 = "BAmAdQFwL1qSj2dL0tBLdhjoipyi0IaoRUW0UWRUzMc=";

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
