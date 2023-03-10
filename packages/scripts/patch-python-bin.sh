source $stdenv/setup

chmod -R u+w "${out}"

newPythonBin=$(command -v python)
echo "replace 'python -c' to '${newPythonBin} -c'"

# files contain "python -c"
files=$(rg "python -c" -l $out)

for f in ${files[@]}; do
    echo "find 'python -c' in ${f}, will be replaced"
    sed -i "s%python -c%${newPythonBin} -c%g" "$f"
done
