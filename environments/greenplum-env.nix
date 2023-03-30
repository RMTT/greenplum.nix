{
    mkShell,
    gitui,
    htop,
    cowsay,
    zsh,
    git,
    gh,
    exa,
    neovim,
    gdb,
    _stdenv ? "",
    greenplumDrv,
    name
}:

let
  hello_message = "Welcome to use and develop Greenplum Database";

  devTools = [
    gitui
    htop
    cowsay
    zsh
    git
    gh
    exa
    neovim
    gdb
  ];

  stdenv = if _stdenv == "" then greenplumDrv.stdenv else _stdenv;
  shell = mkShell.override {stdenv = stdenv;};
in
    shell {
        name = name;
        packages = devTools;
        inputsFrom = [ greenplumDrv ];

        inherit (greenplumDrv) makeFlags preBuild preConfigure postInstall postFixup ;

        shellHook = ''
            cowsay -e ^^ ${hello_message}
            alias ls=exa
        '';
    }
