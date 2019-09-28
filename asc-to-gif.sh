#!/usr/bin/env bash

# Check requirements
hash qrencode 2>/dev/null || { echo >&2 "Aborting: qrencode not installed"; exit 1; }

# Check argument
if [ $# -ne 2 ]; then
    echo "Usage: $0 <ascii armor key filename> <gif filename>"
    exit 1
fi
asc_filename=$1
if [ ! -f ${asc_filename} ]; then
    echo "Error: ${asc_filename} not found"
    exit 1
fi

# Settings
gif_filename=$2
gif_delay=100
qrcode_size=1732
qrcode_version=30

# Split the file
rm -f ${asc_filename}.split*
split -b ${qrcode_size} ${asc_filename} ${asc_filename}.split

# Generate png
for f in ${asc_filename}.split*; do
    qrencode -v ${qrcode_version} -o $f.png < $f
    rm $f
done

if hash zbarimg 2>/dev/null; then
    # Check png
    > ${asc_filename}.scanned
    for f in ${asc_filename}.split*; do
        printf %s "$(zbarimg --raw -q $f)" >> ${asc_filename}.scanned
    done
    printf %s "$(cat ${asc_filename})" | diff ${asc_filename}.scanned -
    rm ${asc_filename}.scanned
else
    echo "Skip testing: zbarimg not installed"
fi

# Convert to gif
convert -delay ${gif_delay} ${asc_filename}.split* ${gif_filename}
echo "Generated: ${gif_filename}"

# Clean up png
rm ${asc_filename}.split*

