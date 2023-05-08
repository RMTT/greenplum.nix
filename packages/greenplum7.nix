{ pkg-config, readline, zlib, zstd, apr, libevent, libxml2, bzip2, curl, libyaml
, xercesc, perl, bison, flex, python3, stdenv, lib, ripgrep, makeWrapper
, srcUrl ? "https://github.com/greenplum-db/gpdb.git", version ? "main"
, rev ? "", ref ? "main", makeFlags ? [ ], configureFlags ? "" }:

let
  buildDeps = [
    pkg-config
    readline
    zlib
    zstd
    apr
    libevent
    libxml2
    bzip2
    curl
    libyaml
    xercesc
    perl
    bison
    flex
    python3
    ripgrep
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
    --with-pythonsrc_ext
    --enable-debug
    CPPFLAGS="-std=c++14"
  '';

in stdenv.mkDerivation {
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
  nativeBuildInputs = [ makeWrapper ];
  buildInputs = buildDeps;
}
