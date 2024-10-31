{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, xorg
, openssl
}:

rustPlatform.buildRustPackage {
  pname = "smartcat";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "efugier";
    repo = "smartcat";
    rev = "eedc6bc16764d3cd9ccb37d7ac0323039ccba724";
    hash = "sha256-1t7t/O157VpnbFkd5RyYVV1QFycMSxd3NMWUmCu3xuc=";
  };

  cargoHash = "sha256-6g1KcMYBqOPTPJxo76vHBVOFSZWYlACz1tZE8VAR/Rk=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ xorg.libX11 openssl ];

  meta = with lib; {
    description = "Integrating language models in the Unix commands ecosystem through text streams.";
    homepage = "https://github.com/efugier/smartcat";
    license = licenses.asl20;
    maintainers = with maintainers; [ thled ];
  };
}
