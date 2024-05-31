{ mkShell
, postgresql
, patroni
, zookeeper
}: mkShell {
  name = "pgdev";
  packages = [ postgresql patroni zookeeper ];
}

