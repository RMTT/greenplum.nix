{ pkgs ? import <nixpkgs> { } }:

let
  repo_pkgs = {

    greenplum-db-6X_STABLE = pkgs.callPackage ./greenplum6.nix {
      makeFlags = [ "-j8" ];
      ref = "6X_STABLE";
    };

    greenplum-db-main =
      pkgs.callPackage ./greenplum7.nix { makeFlags = [ "-j8" ]; };
  };

in repo_pkgs
