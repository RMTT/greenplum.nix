{ stdenv , ref ? "6X_STABLE", buildPkgs ? [] }:

let
    src = fetchGit {
        url = "https://github.com/greenplum-db/gpdb.git";
        submodules = true;
        ref = ref;
    };

in
stdenv.mkDerivation {
    name = "greenplum-db-${ref}-source-patched";
    src = src;
    ref = ref;
    buildInputs = buildPkgs;
    dontPatch = true;
    dontConfigure = true;
    dontBuild = true;
    doCheck = false;
    installPhase = ''
        cp -r $src $out
    '';
    fixupPhase = ./scripts/patch-shebang.sh;
}
