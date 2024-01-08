{ pkgs ? import <nixpkgs> { } }:

let
  repo_pkgs = rec {
    default = "greenplum-db-7.0.0";

    gp-xerces = pkgs.callPackage ./gp-xerces.nix { stdenv = pkgs.clangStdenv; };
    healpix = pkgs.callPackage ./healpix.nix {};

    "greenplum-db-6.23.4" = pkgs.callPackage ./greenplum.nix {
      makeFlags = [ "-j8" ];
      version = "6.23.4";
      ref = "6.23.x";
      rev = "9139fa887752a822b5f7010baa0dcf88233e7d7d";
      gp-xerces = gp-xerces;
    };

    "greenplum-db-7.0.0" = pkgs.callPackage ./greenplum.nix {
      makeFlags = [ "-j8" ];
      version = "7.0.0";
      rev = "0a7a3566873325aca1789ae6f818c80f17a9402d";
      gp-xerces = gp-xerces;
    };
  };

in
repo_pkgs
