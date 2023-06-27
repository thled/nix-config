{ fetchFromGitHub
, gdk-pixbuf
, gtk3
, gtk-layer-shell
, lib
, pkg-config
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "eww";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "elkowar";
    repo = pname;
    rev = "25e50eda46379bccd8a7887c18ee35833e0460e8";
    sha256 = "sha256-8e6gHSg6FDp6nU5v89D44Tqb1lR5aQpS0lXOVqzoUS4=";
  };

  cargoSha256 = "sha256-b5juiwFEBucVgTLVWwSuYQvOwrjXFoUMB+Tv0OUtk60=";

  # cargoPatches = [ ./Cargo.lock.patch ];

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    gdk-pixbuf
    gtk3
    gtk-layer-shell
  ];

  cargoBuildFlags = [ "--bin" "eww" ];
  cargoTestFlags = cargoBuildFlags;

  # requires unstable rust features
  RUSTC_BOOTSTRAP = 1;

  meta = with lib; {
    description = "ElKowars wacky widgets";
    homepage = "https://github.com/elkowar/eww";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda lom ];
  };
}