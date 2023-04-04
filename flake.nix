{
    description = "Greenplum Database";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = {self, nixpkgs, flake-utils} :
        flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
                let
                    pkgs = import nixpkgs {
                        system = system;
                        config = {
                            permittedInsecurePackages = [
                                "python-2.7.18.6"
                            ];
                        };
                    };
                    packages = import ./packages { pkgs = pkgs; };
                    impures = import ./packages/impure.nix { pkgs = pkgs; };
                    environments = import ./environments {pkgs = (pkgs // packages); };
                in
                {
                    packages = packages // impures;
                    devShells = environments;
                    formatter = pkgs.nixfmt;

                    hydraJobs.build = packages;
                }
            );
}
