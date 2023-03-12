{ pkgs ? import <nixpkgs> { } }:
{
    gpenv-6X = pkgs.callPackage ./greenplum-env.nix {
        greenplumDrv = pkgs.greenplum-db-6X_STABLE;
    };

    gpenv-main = pkgs.callPackage ./greenplum-env.nix {
        greenplumDrv = pkgs.greenplum-db-main;
    };
}
