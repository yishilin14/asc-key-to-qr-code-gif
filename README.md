# asc-key-to-qr-code-gif

A script that converts ASCII-armored PGP keys (or any texts) to a series of QR codes.  

This allows to transfer texts from a PC to other devices that can scan and
decode QR codes. The script was originally made for transfering keys into [Pass for iOS](https://github.com/mssun/passforios).

## Dependencies

1. [libqrencode](http://fukuchi.org/works/qrencode/): Generate QR codes.
2. [imagemagick](https://www.imagemagick.org/script/index.php): Convert PNGs to GIF.
3. (Optional) [zbar](http://zbar.sourceforge.net): Read and test QR codes.

## Usage

Execute `./asc-to-gif.sh input.txt output.gif`.

An example of exporting ASCII-armored PGP keys and generate QR codes.

    gpg --export -a "Key ID" > public.asc
    gpg --export-secret-keys -a "Key ID" > private.asc
    ./asc-to-gif.sh public.asc public.gif
    ./asc-to-gif.sh private.asc private.gif

### Docker

You can use [docker](https://docs.docker.com/) to perform the conversions:

```
docker build . -t asc-key-to-qr-code-gif
docker run --rm -v $(pwd):/data -e "SRC=/data/public.asc" -e "DST=/data/public.gif" asc-key-to-qr-code-gif
docker run --rm -v $(pwd):/data -e "SRC=/data/private.asc" -e "DST=/data/private.gif" asc-key-to-qr-code-gif
```
