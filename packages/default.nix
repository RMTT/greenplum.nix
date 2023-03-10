{ pkgs ? import <nixpkgs> { } }:

let
    repo_pkgs = {
        greenplum-db-6-23-3 = pkgs.callPackage ./greenplum6.nix {
            stdenv = pkgs.gcc8Stdenv;
            makeFlags = ["-j8"];
            tag = "6.23.3";
        };

        greenplum-db-6X_STABLE = pkgs.callPackage ./greenplum6.nix {
            stdenv = pkgs.gcc8Stdenv;
            makeFlags = ["-j8"];
        };

        greenplum-db-main = pkgs.callPackage ./greenplum7.nix {
            stdenv = pkgs.gcc12Stdenv;
            makeFlags = ["-j8"];
        };

        greenplum-db-7-0-0-beta-1 = pkgs.callPackage ./greenplum7.nix {
            stdenv = pkgs.gcc12Stdenv;
            makeFlags = ["-j8"];
            tag = "7.0.0-beta.1";
        };
    };

in repo_pkgs
