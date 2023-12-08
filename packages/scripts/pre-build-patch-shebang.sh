# replace /usr/bin/xx with absolute path

source $stdenv/setup

chmod -R u+w .

patchShebangs --host src/include/catalog/duplicate_oids
patchShebangs --host gpMgmt/bin/generate-greenplum-path.sh


# modify /bin/bash
newBash=$(command -v bash)

files=(src/test/isolation2/sql_isolation_testcase.py)
for f in "${files[@]}"; do
    echo "find '/bin/bash' in ${f}, will be replaced"
    sed -i "1 ! s%/bin/bash%${newBash}%g" "$f"
done
