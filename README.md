# Greenplum for nix

## Prerequisite
Install [Nix](https://nixos.org/)

## Usage

### Install Greenplum Package

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
nix-env -i {greenplum version}
```

To start shell with specific greenplum version:
```
nix-shell -p {greeplum version}
```

### Use Greenplum development envrionment

List all avaible environment:
```shell
nix-env -qa "gpenv.*"
```

Enter environment:
```shell
nix-shell "<greenplum>" -A {gpenv version}
```
