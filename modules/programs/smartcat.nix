{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, openssl
}:

rustPlatform.buildRustPackage {
  pname = "smartcat";
  version = "2.1.0";

  src = fetchFromGitHub {
    owner = "efugier";
    repo = "smartcat";
    rev = "a3543ccfdd9649d7bb3debb7b2a58906abb617cc";
    hash = "sha256-QoMBQ/Xjh/xbsE9HthUKwm5v2tiN1tC2u6I/aOeO6ws=";
  };

  cargoHash = "sha256-SAv2tgo5jBSsVhLM2FR5S9Sg0yZBghSKKSV9hhUCvCk=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ openssl ];

  meta = with lib; {
    description = "Integrating language models in the Unix commands ecosystem through text streams.";
    homepage = "https://github.com/efugier/smartcat";
    license = licenses.asl20;
    maintainers = with maintainers; [ thled ];
  };
}
