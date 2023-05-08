{ stdenv }:
let
  src = fetchGit {
    url = "https://github.com/greenplum-db/gp-xerces";
    submodules = true;
    rev = "f07c17da813f44d8da17067a76491ca4b1deb02f";
  };
in stdenv.mkDerivation {
  pname = "gp-xerces";
  version = "1.0";
  system = builtins.currentSystem;
  src = src;
}
