{ fetchFromGitHub
, installShellFiles
, lib
, rustPlatform
, scdoc
}:

rustPlatform.buildRustPackage rec {
  pname = "uair";
  version = "v0.4.0";

  src = fetchFromGitHub {
    owner = "metent";
    repo = pname;
    rev = "e24fe2756e1a183e7bd42b7cb9275e8f5d8e6b34";
    hash = "sha256-a4ANeHwcvEP9uaxiQqO87ab4HW4AQu2jk2es7d42/Is=";
  };

  cargoHash = "sha256-hunl2RXZGuNJHSQPH7Vp9ONG5hYAt6Ba+EI+A1PykCo=";

  nativeBuildInputs = [ installShellFiles scdoc ];

  preFixup = ''
    scdoc < docs/uair.1.scd > docs/uair.1
    scdoc < docs/uair.5.scd > docs/uair.5
    scdoc < docs/uairctl.1.scd > docs/uairctl.1

    installManPage docs/*.[1-9]
  '';

  meta = with lib; {
    description = "An extensible pomodoro timer";
    homepage = "https://github.com/metent/uair";
    license = licenses.mit;
    maintainers = [ maintainers.metent ];
  };
}
