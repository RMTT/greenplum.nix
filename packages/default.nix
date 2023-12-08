{ pkgs ? import <nixpkgs> { } }:

let
  repo_pkgs = rec {
    default = greenplum-db-7-0-0-beta-1;

    gp-xerces = pkgs.callPackage ./gp-xerces.nix { stdenv = pkgs.clangStdenv; };

    greenplum-db-6-23-4 = pkgs.callPackage ./greenplum.nix {
      makeFlags = [ "-j8" ];
      version = "6.23.4";
      ref = "6.23.x";
      rev = "9139fa887752a822b5f7010baa0dcf88233e7d7d";
      gp-xerces = gp-xerces;
    };

    greenplum-db-7-0-0-beta-1 = pkgs.callPackage ./greenplum.nix {
      makeFlags = [ "-j8" ];
      version = "7.0.0-beta.1";
      rev = "ba1d71c5513d2c45a286392e8cae9abc620376ad";
      gp-xerces = gp-xerces;
    };
  };

in repo_pkgs
