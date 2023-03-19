{
    description = "Greenplum Database";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs";
    };

    outputs = {self, nixpkgs} : {
        packages.x86_64-linux = import ./packages { pkgs = nixpkgs.legacyPackages.x86_64-linux; };
    };
}
