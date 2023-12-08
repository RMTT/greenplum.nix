{ pkgs ? import <nixpkgs> { } }: rec {
  default = gpenv;

  gpenv = pkgs.callPackage ./greenplum-env.nix {
    greenplumDrv = pkgs.greenplum-db-6-23-4.override {
      configureFlags = ''"--enable-debug" '';
    };

    name = "gpenv";
  };

  gpenv-common = pkgs.callPackage ./greenplum-env.nix {
    greenplumDrv = pkgs.greenplum-db-6-23-4.override {
      configureFlags = ''"--enable-debug" '';
    };

    extraNativePkgs = with pkgs; [ cmake ];
    extraPkgs = with pkgs; [ virtualenv ant jdk8 ];

    name = "gpenv-common";
  };
}
