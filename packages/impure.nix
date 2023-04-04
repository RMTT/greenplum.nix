{ pkgs ? import <nixpkgs> { } }:

let
    repo_pkgs = {

        greenplum-db-6X_STABLE = pkgs.callPackage ./greenplum6.nix {
            stdenv = pkgs.gcc8Stdenv;
            makeFlags = ["-j8"];
        };

        greenplum-db-main = pkgs.callPackage ./greenplum7.nix {
            stdenv = pkgs.gcc12Stdenv;
            makeFlags = ["-j8"];
        };
    };

in repo_pkgs
