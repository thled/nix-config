{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, openssl
}:

rustPlatform.buildRustPackage rec {
  pname = "smartcat";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "efugier";
    repo = "smartcat";
    rev = "refs/tags/${version}";
    hash = "sha256-nXuMyHV5Sln3qWXIhIDdV0thSY4YbvzGqNWGIw4QLdM=";
  };

  cargoHash = "sha256-tR7+SecTS1FWwcPF25PclT6lEjY9NUEj/2EBhbgg0tw=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ openssl ];

  meta = with lib; {
    description = "Integrating language models in the Unix commands ecosystem through text streams.";
    homepage = "https://github.com/efugier/smartcat";
    license = licenses.asl20;
    maintainers = with maintainers; [ thled ];
  };
}
