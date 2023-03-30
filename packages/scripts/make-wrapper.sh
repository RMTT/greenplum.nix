files=$(find "$out"/bin -maxdepth 1  -type f -executable)

source "$stdenv"/setup

for _file in $files; do
    # only wrap scripts
    if file "$_file" | grep -iq ASCII; then
        wrapProgram "$_file" \
            --prefix GPHOME '' "$out" \
            --prefix PYTHONPATH ':' "$out"/lib/python
    fi
done
