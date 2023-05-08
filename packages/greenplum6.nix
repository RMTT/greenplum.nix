{ pkg-config, readline, zlib, zstd, apr, libevent, libxml2, bzip2, libyaml, curl
, xercesc, perl, bison, flex, python2, stdenv, lib, ripgrep, makeWrapper
, srcUrl ? "https://github.com/greenplum-db/gpdb.git", version ? "6X_STABLE"
, rev ? "", ref ? "6X_STABLE", makeFlags ? [ ], configureFlags ? "" }:

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
    libyaml
    curl
    xercesc
    perl
    bison
    flex
    python2
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
    CPPFLAGS="-std=c++11"
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
