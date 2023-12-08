source "$stdenv"/setup

chmod -R u+w "${out}"

newPythonBin=$(command -v python)
echo "replace 'python -c' to '${newPythonBin} -c'"

# files contain "python -c"
files=$(rg "python -c" -l $out)

for f in ${files[@]}; do
    echo "find 'python -c' in ${f}, will be replaced"
    sed -i "s%python -c%${newPythonBin} -c%g" "$f"
done


newPythonBin=$(command -v python3)
echo "replace 'python3 -c' to '${newPythonBin} -c'"

# files contain "python -c"
files=$(rg "python3 -c" -l $out)

for f in ${files[@]}; do
    echo "find 'python3 -c' in ${f}, will be replaced"
    sed -i "s%python3 -c%${newPythonBin} -c%g" "$f"
done

# patch /bin/bash in file content
newBash=$(command -v bash)

# files contain "/bin/bash"
files=$(rg "/bin/bash" -l $out)

for f in ${files[@]}; do
    echo "find '/bin/bash' in ${f}, will be replaced"
    sed -i "1 ! s%/bin/bash%${newBash}%g" "$f"
done
