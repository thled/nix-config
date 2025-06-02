{
  lib,
  fetchFromGitHub,
  rustPlatform,
  stdenv,
  python3,
}:
rustPlatform.buildRustPackage rec {
  pname = "jless";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "thled";
    repo = "jless";
    rev = "f0d94a492ea06032bddc47393c49de345c3d5a64";
    hash = "sha256-V7vcJfp6SE7ue2woBODgXbnEXyhWXmgHZcTIMTucWVo=";
  };

  cargoHash = "sha256-+5MgocX/Wur1yVNcYFwMcJq37cdIZRsVuHE+4GHiQqo=";

  nativeBuildInputs = lib.optionals stdenv.hostPlatform.isLinux [python3];

  meta = with lib; {
    description = "Command-line pager for JSON data";
    mainProgram = "jless";
    homepage = "https://jless.io";
    changelog = "https://github.com/thled/jless/blob/${src.rev}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [thled];
  };
}
