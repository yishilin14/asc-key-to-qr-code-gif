#!/bin/bash

# Check argument
if [ $# -ne 2 ]; then
    echo "Usage: $0 <ascii armor key file> <gif file>"
    exit 1
fi
asc_filename=$1
gif_filename=$2
if [ ! -f ${asc_filename} ]; then
    echo "Error: ${asc_filename} not found"
    exit 1
fi

# Settings
gif_delay=50
qrcode_size=1735
qrcode_version=30

# Split the file
rm -f ${asc_filename}.split*
split -b ${qrcode_size} ${asc_filename} ${asc_filename}.split

# Generate png
for f in ${asc_filename}.split*; do
    qrencode -v ${qrcode_version} -o $f.png < $f
    rm $f
done

# Check png
> ${asc_filename}.scanned
for f in ${asc_filename}.split*; do
    printf %s "$(zbarimg --raw -q $f)" >> ${asc_filename}.scanned
done
printf %s "$(cat ${asc_filename})" | diff ${asc_filename}.scanned -
rm ${asc_filename}.scanned

# Convert to gif
convert -delay ${gif_delay} ${asc_filename}.split* ${gif_filename}

# Clean up png
rm ${asc_filename}.split*

