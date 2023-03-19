{ pkgs ? import <nixpkgs> { } }:

let
    repo_pkgs = rec {
        default = greenplum-db-main;

        greenplum-db-6-23-3 = pkgs.callPackage ./greenplum6.nix {
            stdenv = pkgs.gcc8Stdenv;
            makeFlags = ["-j8"];
            version = "6.23.3";
            rev = "0eb759d759987e82ba3bf910b89ed3057bad0416";
        };

        greenplum-db-6X_STABLE = pkgs.callPackage ./greenplum6.nix {
            stdenv = pkgs.gcc8Stdenv;
            makeFlags = ["-j8"];
            rev = "5ee1530829413dd820d82178e289f7cc8c7be363";
        };

        greenplum-db-main = pkgs.callPackage ./greenplum7.nix {
            stdenv = pkgs.gcc12Stdenv;
            makeFlags = ["-j8"];
            rev = "18710643c4a00bfa99c2ed4f54c19c4d03b5394e";
        };

        greenplum-db-7-0-0-beta-1 = pkgs.callPackage ./greenplum7.nix {
            stdenv = pkgs.gcc12Stdenv;
            makeFlags = ["-j8"];
            version = "7.0.0-beta.1";
            rev = "ba1d71c5513d2c45a286392e8cae9abc620376ad";
        };
    };

in repo_pkgs
