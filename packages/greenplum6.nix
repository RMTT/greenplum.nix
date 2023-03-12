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
        libyaml
        curl
        xercesc
        perl
        bison
        flex
        python2
        ripgrep
    ];

    ref = if tag == "" then "6X_STABLE" else "refs/tags/${tag}";
    src = import ./greenplum-patch.nix { stdenv = stdenv; ref = ref; buildPkgs = buildDeps; };

    name = if tag == "" then "greenplum-db-${ref}" else "greenplum-db-${tag}";
    version = if tag == "" then "6X_STABLE" else tag;
    defaultConfigureFlags = ''
        --with-libxml
        --enable-cassert
        --with-python
        --with-pythonsrc_ext
        CPPFLAGS="-std=c++11"
    '';
    greenplum6 = stdenv.mkDerivation {
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
in greenplum6
