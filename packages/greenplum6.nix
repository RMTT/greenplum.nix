{
    pkg-config,
    readline,
    zlib,
    zstd,
    apr,
    libevent,
    libxml2,
    bzip2,
    libyaml,
    curl,
    xercesc,
    perl,
    bison,
    flex,
    python2,
    stdenv,
    lib,
    ripgrep,
    version ? "6X_STABLE",
    rev ? "",
    makeFlags ? [],
    configureFlags ? ""
}:

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

    src = fetchGit {
        url = "https://github.com/greenplum-db/gpdb.git";
        submodules = true;
        rev = rev;
    };

    defaultConfigureFlags = ''
        --with-libxml
        --enable-cassert
        --with-python
        --with-pythonsrc_ext
        CPPFLAGS="-std=c++11"
    '';
    greenplum6 = stdenv.mkDerivation {
        name = "greenplum-db";
        version = version;
        meta = with lib; {
            license = licenses.asl20;
        };
        system = builtins.currentSystem;
        src = src;
        makeFlags = makeFlags;
        postUnpack = ./scripts/patch-shebang.sh;
        preConfigure = ''
            configureFlagsArray+=(${defaultConfigureFlags})
            configureFlagsArray+=(${configureFlags})
        '';
        postFixup = ./scripts/patch-python-bin.sh;
        buildInputs = buildDeps;
    };
in greenplum6
