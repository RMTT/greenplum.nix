{ pkgs ? import <nixpkgs> { } }: rec {
  default = gpenv;

  gpenv = pkgs.callPackage ./greenplum-env.nix {
    greenplumDrv = pkgs.greenplum-db-6-23-4.override {
      configureFlags = ''"--enable-debug" '';
    };

    name = "gpenv";
  };
}
