{
    pkg-config,
    readline,
    zlib,
    zstd,
    apr,
    libevent,
    libxml2,
    bzip2,
    curl,
    libyaml,
    xercesc,
    perl,
    bison,
    flex,
    python3,
    stdenv,
    lib,
    ripgrep,
    version ? "main",
    rev,
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
        curl
        libyaml
        xercesc
        perl
        bison
        flex
        python3
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
        CPPFLAGS="-std=c++14"
    '';

in
    stdenv.mkDerivation {
        pname = "greenplum-db";
        version = version;

        meta = with lib; {
            license = licenses.asl20;
        };
        system = builtins.currentSystem;
        src = src;
        makeFlags = makeFlags;
        patchPhase = ./scripts/patch-shebang.sh;
        preConfigure = ''
            configureFlagsArray+=(${defaultConfigureFlags})
            configureFlagsArray+=(${configureFlags})
        '';
        postFixup = ./scripts/patch-python-bin.sh;
        buildInputs = buildDeps;
    }
