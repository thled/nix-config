{
  lib,
  stdenv,
  fetchFromGitHub,
  fpc,
  lazarus-qt6,
  qt6Packages,
  libx11,
  mariadb-connector-c,
  postgresql,
  sqlite,
  freetds,
  openssl,
  openssh,
  sshpass,
  coreutils,
  findutils,
}:
let
  dbLibDirs = [
    "${lib.getLib mariadb-connector-c}/lib/mariadb"
    "${lib.getLib postgresql.lib}/lib"
    "${lib.getLib sqlite}/lib"
    "${lib.getLib freetds}/lib"
    "${lib.getLib openssl}/lib"
  ];

  dbLibPath = lib.concatStringsSep ":" dbLibDirs;

  # Expose client libraries through the system profile so HeidiSQL can persist
  # stable paths in session configs across nixpkgs upgrades.
  stableDbLibDir = "/run/current-system/sw/lib/heidisql/db-libs";
in
stdenv.mkDerivation (finalAttrs: {
  pname = "heidisql";
  version = "12.17";

  src = fetchFromGitHub {
    owner = "HeidiSQL";
    repo = "HeidiSQL";
    tag = finalAttrs.version;
    hash = "sha256-E8GDOjEKKalRBl6TIJMxyORy5dWwOS5jcRDr7lUka7Y=";
  };

  nativeBuildInputs = [
    fpc
    lazarus-qt6
    qt6Packages.wrapQtAppsHook
  ];

  buildInputs = [
    qt6Packages.qtbase
    qt6Packages.qtwayland
    qt6Packages.libqtpas
    libx11
  ];

  dontWrapQtApps = true;

  env.NIX_LDFLAGS = "--as-needed -rpath ${lib.makeLibraryPath finalAttrs.buildInputs}";

  postPatch = ''
    substituteInPlace source/dbconnection.pas \
      --replace-fail /sbin/ldconfig $out/bin/heidisql-ldconfig
  '';

  buildPhase = ''
    runHook preBuild

    export HOME=$(mktemp -d)
    lazbuild \
      --lazarusdir=${lazarus-qt6}/share/lazarus \
      --widgetset=qt6 \
      --build-all \
      --build-mode=Release \
      heidisql.lpi

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -Dm755 out/heidisql $out/share/heidisql/heidisql
    install -Dm644 package-skeleton/usr/share/applications/heidisql.desktop \
      $out/share/applications/heidisql.desktop
    install -Dm644 res/deb-package-icon.png $out/share/pixmaps/heidisql.png
    install -Dm644 README.md $out/share/doc/heidisql/README.md
    install -Dm644 LICENSE $out/share/doc/heidisql/LICENSE

    cp -r extra/locale $out/share/heidisql/
    cp extra/ini/*.ini $out/share/heidisql/

    install -d $out/bin $out/lib/heidisql/db-libs
    ln -s ${lib.getLib mariadb-connector-c}/lib/mariadb/libmariadb.so \
      $out/lib/heidisql/db-libs/libmariadb.so
    ln -s ${lib.getLib mariadb-connector-c}/lib/mariadb/libmysqlclient.so \
      $out/lib/heidisql/db-libs/libmysqlclient.so
    ln -s ${lib.getLib postgresql.lib}/lib/libpq.so \
      $out/lib/heidisql/db-libs/libpq.so
    ln -s ${lib.getLib sqlite}/lib/libsqlite3.so \
      $out/lib/heidisql/db-libs/libsqlite3.so
    ln -s ${lib.getLib freetds}/lib/libsybdb.so \
      $out/lib/heidisql/db-libs/libsybdb.so

    cat > $out/bin/heidisql-ldconfig <<EOF
#!${stdenv.shell}
set -eu

if [ "\''${1-}" = "-p" ]; then
  seen=""

  emit_dir() {
    local d="\$1"
    local entry name

    [ -d "\$d" ] || return 0

    while IFS= read -r entry; do
      name="\''${entry%% => *}"

      case " \$seen " in
        *" \$name "*) ;;
        *)
          printf '%s\n' "\$entry"
          seen="\''${seen} \$name"
          ;;
      esac
    done < <(
      ${findutils}/bin/find -L "\$d" -maxdepth 1 \( \
        -name 'libmariadb.so*' -o \
        -name 'libmysqlclient.so*' -o \
        -name 'libperconaserverclient.so*' -o \
        -name 'libpq.so*' -o \
        -name 'libsqlite3.so*' -o \
        -name 'libsybdb.so*' -o \
        -name 'libgds32.so*' -o \
        -name 'libibclient.so*' -o \
        -name 'libfbclient.so*' \
      \) -printf '%f => %p\n' | ${coreutils}/bin/sort
    )
  }

  emit_dir ${stableDbLibDir}
  emit_dir $out/lib/heidisql/db-libs
  exit 0
fi

exec ${coreutils}/bin/false "\$@"
EOF
    chmod +x $out/bin/heidisql-ldconfig

    makeQtWrapper $out/share/heidisql/heidisql $out/bin/heidisql \
      --prefix LD_LIBRARY_PATH : ${dbLibPath} \
      --prefix PATH : ${lib.makeBinPath [ openssh sshpass ]}

    runHook postInstall
  '';

  meta = with lib; {
    description = "Powerful SQL client for everyday database work";
    homepage = "https://www.heidisql.com";
    license = licenses.gpl2Plus;
    platforms = [ "x86_64-linux" ];
    mainProgram = "heidisql";
  };
})
