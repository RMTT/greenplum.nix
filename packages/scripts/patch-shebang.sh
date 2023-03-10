# replace /usr/bin/xx with env xx

source $stdenv/setup

chmod -R u+w "${out}"
patchShebangs --host $out/src/include/catalog/duplicate_oids
patchShebangs --host $out/gpMgmt/bin/generate-greenplum-path.sh
