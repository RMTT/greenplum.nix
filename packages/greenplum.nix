{ pkg-config, readline, zlib, zstd, apr, libevent, libxml2, bzip2, curl, libyaml
, gp-xerces, perl, bison, json_c, flex, python2, python3, clangStdenv, gcc, lib
, clang-tools, makeWrapper, srcUrl ? "https://github.com/greenplum-db/gpdb.git"
, version ? "main", rev ? "", ref ? "main", makeFlags ? [ ], configureFlags ? ""
}:
let
  buildDeps = [
    gcc # need gcc for python modules even we use clang to build greenplum
    pkg-config
    readline
    zlib
    zstd
    apr
    libevent
    libxml2
    json_c
    bzip2
    curl
    libyaml
    gp-xerces
    perl
    bison
    flex
    python2
    (python3.withPackages (ps: with ps; [ psycopg2 jinja2 setuptools ]))
  ];

  src = if rev == "" then
    fetchGit {
      url = srcUrl;
      submodules = true;
      ref = ref;
    }
  else
    fetchGit {
      url = srcUrl;
      submodules = true;
      rev = rev;
      ref = ref;
    };

  defaultConfigureFlags = ''
        --with-libxml
        --enable-cassert
        --with-python
        --with-openssl
    		--with-pythonsrc-ext
  '';

in clangStdenv.mkDerivation {
  pname = "greenplum-db";
  version = version;

  meta = with lib; { license = licenses.asl20; };
  system = builtins.currentSystem;
  src = src;
  makeFlags = makeFlags;
  preConfigure = ''
    configureFlagsArray+=(${defaultConfigureFlags})
    configureFlagsArray+=(${configureFlags})
  '';
  postConfigure = ./scripts/pre-build-patch-shebang.sh;
  postInstall = ./scripts/make-wrapper.sh;
  postFixup = ./scripts/patch-bin.sh;
  nativeBuildInputs = [ clang-tools makeWrapper ];
  buildInputs = buildDeps;
}
