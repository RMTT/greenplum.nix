{ pkgs ? import <nixpkgs> { } }:
rec {
  default = gpenv;

  gpenv = pkgs.callPackage ./greenplum-env.nix {
    greenplumDrv = pkgs."greenplum-db-7.0.0".override {
      configureFlags = ''"--enable-debug" '';
    };

    name = "gpenv";
  };

  gpenv-common = pkgs.callPackage ./greenplum-env.nix {
    greenplumDrv = pkgs."greenplum-db-7.0.0".override {
      configureFlags = ''"--enable-debug" '';
    };

    extraNativePkgs = with pkgs; [ cmake ];
    extraPkgs = with pkgs; [ ant jdk8 rustc cargo healpix ];

    name = "gpenv-common";
  };

  pgenv = pkgs.callPackage ./postgresql.nix { };
}
