{ pkgs ? import <nixpkgs> { } }:
let
    envs = import ./environments {pkgs = (pkgs // packages);};
    packages = (import ./packages {pkgs = pkgs;}) // (import ./packages/impure.nix {pkgs = pkgs;});
in envs  // packages
