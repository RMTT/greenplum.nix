# Greenplum for nix

## Prerequisite
Install [Nix](https://nixos.org/)

## Usage

### Install Greenplum Package

```shell
nix registry add greenplum github:RMTT/greenplum.nix
```

Now, you can install some gpdb versions which have been defined in this repo:
```shell
nix search greenplum
```

To install greenplum db:
```
nix profile install {greenplum version}
```

To start shell with specific greenplum version:
```
nix shell greenplum#{greenplum version}
```

### Use Greenplum development envrionment

Enter environment:
```shell
nix develop greenplum#{greenplum version}
```
