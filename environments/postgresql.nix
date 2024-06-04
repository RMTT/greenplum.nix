{ mkShell
, postgresql
, patroni
, zookeeper
, python3
, go
, vault
, gdk
, jsonnet
, minio-client
, kubernetes-helm
, envsubst
, lastpass-cli
,
}: mkShell {
  name = "pgdev";
  packages = [
    postgresql
    patroni
    zookeeper
    (python3.withPackages (ps: with ps; [ psycopg2 setuptools ]))
    go
    vault
    gdk
    jsonnet
    minio-client
    kubernetes-helm
    envsubst
    lastpass-cli
  ];
}

