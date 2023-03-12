{ pkgs ? import <nixpkgs> { } }:
let
    envs = import ./environments {pkgs= (pkgs // packages);};
    packages = import ./packages {pkgs=pkgs;};
in envs  // packages
