{ mkShell, gitui, htop, direnv, ripgrep, cowsay, exa, bear, openssh, _stdenv ? ""
, greenplumDrv, name, extraPkgs ? [ ], extraNativePkgs ? [ ] }:

let
  stdenv = if _stdenv == "" then greenplumDrv.stdenv else _stdenv;
  gpenv = stdenv.mkDerivation {
    pname = "gpenv";
    version = "0.1";
    src = ./scripts/gpenv.sh;
    dontUnpack = true;
    dontPatch = true;
    dontConfigure = true;
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/gpenv
    '';
  };

  hello_message = "Welcome to use and develop Greenplum Database";

  devTools = [ gitui htop cowsay exa direnv bear gpenv openssh ripgrep ];

  shell = mkShell.override { stdenv = stdenv; };
in shell {
  name = name;
  packages = devTools ++ extraPkgs;
  nativeBuildInputs = extraNativePkgs;
  noDumpEnvVars = 1;
  inputsFrom = [ greenplumDrv ];
  dontStrip = true;

  inherit (greenplumDrv)
    makeFlags preConfigure postConfigure postInstall postFixup;

  shellHook = ''
    cowsay -e ^^ ${hello_message}
    alias ls=exa
  '';
}
