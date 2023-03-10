# Greenplum for nix

## Prerequisite
Install [Nix](https://nixos.org/)

## Usage
```shell
nix-channel --add "https://github.com/RMTT/greenplum.nix/archive/main.tar.gz" greenplum
nix-channel --update
```

Now, you can install some gpdb versions which have been defined in this repo:
```shell
nix-env -qa "greenplum.*"
```

To install greenplum db:
```
nix-env -ia {greenplum version}
```

To start shell with specific greenplum version:
```
nix-shell -p {greeplum version}
```
