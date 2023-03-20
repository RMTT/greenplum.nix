{
    description = "Greenplum Database";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = {self, nixpkgs, flake-utils} :
        flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
                let pkgs = nixpkgs.legacyPackages.${system}; in
                { packages = import ./packages { pkgs = pkgs; }; }
            );
}
