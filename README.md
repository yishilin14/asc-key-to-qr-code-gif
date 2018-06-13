# asc-key-to-qr-code-gif

A simple script to convert ASCII-armored PGP keys to animated QR code (GIF).

## Dependencies

This script depends on the following libraries.

1. [libqrencode](http://fukuchi.org/works/qrencode/): We use it to generate QR codes.  
2. [imagemagick](https://github.com/ImageMagick/ImageMagick): We use it to generate the gif.
3. [zbar](http://zbar.sourceforge.net): We use it to read QR codes and test them. You don't need it if you do not want to test (comment out the "Check png" section in the script).

## Usage

Export you keys first, then use the script.

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
