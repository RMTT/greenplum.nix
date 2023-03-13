{
    mkShell,
    gitui,
    htop,
    cowsay,
    zsh,
    git,
    gh,
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
    neovim
    gdb
  ];

  gpDrvBuildInputs = greenplumDrv.buildInputs;

  stdenv = if _stdenv == "" then greenplumDrv.stdenv else _stdenv;
  shell = mkShell.override {stdenv = stdenv;};
in
    shell {
        name = name;
        packages = devTools;
        inputsFrom = [ greenplumDrv ];
        shellHook = ''
            cowsay -e ^^ ${hello_message}
        '';
    }
