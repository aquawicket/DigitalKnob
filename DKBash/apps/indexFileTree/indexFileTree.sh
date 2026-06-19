

# https://stackoverflow.com/a/46383157/688352

find . -type d -print -exec sh -c 'tree "$0" \
    -H "." \
    -L 1 \
    --noreport \
    --houtro "" \
    --dirsfirst \
    --charset utf-8 \
    -I "index.htm" \
    -T "DigitalKnob" \
    --ignore-case \
    --timefmt "%d-%b-%Y %H:%M" \
    -s \
    -D \
    -o "$0/index.htm"' {} \;