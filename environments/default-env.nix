{ pkgs ? import <nixpkgs> {} }:

let
  hello_message = "Welcome to use and develop Greenplum Database";

  devTools = with pkgs; [
    ripgrep
    gitui
    htop
    cowsay
    zsh
    git
    gh
    neovim
    man
    man-pages
    pipenv
    gdb
  ];

  devDependencies = with pkgs; [
    readline
    zlib
    zstd
    apr
    libevent
    libxml2
    bzip2
    curl
    libxcrypt
    bison
    flex
    perl
    python3Full
  ];

  shell = pkgs.mkShell.override {stdenv = pkgs.gcc12Stdenv;};
in
  shell {
    name = "gpenv";
    buildInputs = devTools ++ devDependencies;
    shellHook = ''
      cowsay -e ^^ ${hello_message}
    '';

    LC_ALL = "en_US.UTF-8";
    LANGUAGE = "en_US.UTF-8";
    LOCALE_ARCHIVE="${pkgs.glibcLocales}/lib/locale/locale-archive";
  }
