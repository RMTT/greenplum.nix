{ mkShell, gitui, htop, direnv, cowsay, exa, bear, openssh, _stdenv ? ""
, greenplumDrv, name }:

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

  devTools = [ gitui htop cowsay exa direnv bear gpenv openssh ];

  shell = mkShell.override { stdenv = stdenv; };
in shell {
  name = name;
  packages = devTools;
  noDumpEnvVars = 1;
  inputsFrom = [ greenplumDrv ];
  dontStrip = true;

  inherit (greenplumDrv) makeFlags preBuild preConfigure postInstall postFixup;

  shellHook = ''
    cowsay -e ^^ ${hello_message}
    alias ls=exa
  '';
}
