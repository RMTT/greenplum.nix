{ mkShell
, postgresql
, patroni
, zookeeper
, python3
, go
, vault
, jsonnet
, minio-client
, kubernetes-helm
, envsubst
, lastpass-cli
, google-cloud-sdk
}:
let
  gdk = google-cloud-sdk.withExtraComponents (with google-cloud-sdk.components; [
    gke-gcloud-auth-plugin
  ]);
in
mkShell {
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

