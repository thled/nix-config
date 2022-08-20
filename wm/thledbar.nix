{ stdenv, lib, fetchurl, autoPatchelfHook }:
stdenv.mkDerivation rec {
  pname = "thledbar";
  version = "0.1.1";
  src = fetchurl {
    url = "https://github.com/thled/thledbar/releases/download/v0.1.1/thledbar";
    sha256 = "4af9facf9037fc991cce293ed2d5a54ce3c1e1e020ddb865f01704b62b0674ba";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/thledbar
  '';

  meta = with lib; {
    homepage = https://github.com/thled/thledbar;
    description = "ThledBar";
    platforms = platforms.linux;
  };
}
