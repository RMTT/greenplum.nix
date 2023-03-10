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
    tag ? "",
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

    ref = if tag == "" then "main" else "refs/tags/${tag}";
    src = import ./greenplum-patch.nix { stdenv = stdenv; ref = ref; buildPkgs = buildDeps; };

    name = if tag == "" then "greenplum-db-${ref}" else "greenplum-db-${tag}";
    version = if tag == "" then "main" else tag;
    defaultConfigureFlags = ''
        --with-libxml
        --enable-cassert
        --with-python
        --with-pythonsrc_ext
        CPPFLAGS="-std=c++14"
    '';
    greenplum7 = stdenv.mkDerivation {
        name = name;
        version = version;
        meta = with lib; {
            license = licenses.asl20;
        };
        system = builtins.currentSystem;
        src = src;
        makeFlags = makeFlags;
        preConfigure = ''
            configureFlagsArray+=(${defaultConfigureFlags})
            configureFlagsArray+=(${configureFlags})
        '';
        postFixup = ./scripts/patch-python-bin.sh;
        buildInputs = buildDeps;
    };
in greenplum7
