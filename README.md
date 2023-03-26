# Greenplum for nix

## Prerequisite
+ Install [Nix](https://nixos.org/download.html#download-nix)
+ Enable [flakes](https://nixos.wiki/wiki/Flakes#Permanent)

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

#### Steps

+ set out environment to your prefix(default is `$(pwd)/outputs/out`
+ run `configurePhase`
+ run `buildPhase`
+ run `installPhase`
+ run `fixupPhase`
+ now gpdb has installed to `$out`

## FAQ

#### Problem 1: cannot find locale

Solution:
+ set [locale_archive](https://nixos.wiki/wiki/Locales)
+ set ssh send environments: `LANG` `LC_ALL` `LOCALE_ARCHIVE` on **ssh client and server**
