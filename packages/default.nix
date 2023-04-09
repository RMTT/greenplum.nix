{ pkgs ? import <nixpkgs> { } }:

let
    repo_pkgs = rec {
        default = greenplum-db-7-0-0-beta-1;

        greenplum-db-6-23-4 = pkgs.callPackage ./greenplum6.nix {
            stdenv = pkgs.gcc8Stdenv;
            makeFlags = ["-j8"];
            version = "6.23.4";
            ref = "6.23.x";
            rev = "9139fa887752a822b5f7010baa0dcf88233e7d7d";
        };

        greenplum-db-7-0-0-beta-1 = pkgs.callPackage ./greenplum7.nix {
            stdenv = pkgs.gcc12Stdenv;
            makeFlags = ["-j8"];
            version = "7.0.0-beta.1";
            rev = "ba1d71c5513d2c45a286392e8cae9abc620376ad";
        };

        greenplum-db-rg-io = pkgs.callPackage ./greenplum7.nix {
            stdenv = pkgs.gcc12Stdenv;
            makeFlags = ["-j8"];
            version = "rg_io";
            srcUrl = "https://github.com/RMTT/gpdb.git";
            rev = "7e8e8dc7627a8c72e06cb363e240ce7cd6eaceaa";
            ref = "rg_io";
        };
    };

in repo_pkgs
