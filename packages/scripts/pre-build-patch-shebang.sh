# replace /usr/bin/xx with absolute path

source $stdenv/setup

chmod -R u+w .

patchShebangs --host src/include/catalog/duplicate_oids
patchShebangs --host gpMgmt/bin/generate-greenplum-path.sh
