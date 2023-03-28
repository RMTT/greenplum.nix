{ pkgs ? import <nixpkgs> { } }:
rec {
    default = gpenv-main;

    gpenv-6X = pkgs.callPackage ./greenplum-env.nix {
        greenplumDrv = pkgs.greenplum-db-6-23-4;
        name = "gpenv-6X";
    };

    gpenv-main = pkgs.callPackage ./greenplum-env.nix {
        greenplumDrv = pkgs.greenplum-db-7-0-0-beta-1;
        name = "gpenv-main";
    };
}
