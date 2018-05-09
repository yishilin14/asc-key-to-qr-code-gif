FROM alpine:3.3

RUN apk --update add --no-cache imagemagick bash libqrencode

ADD asc-to-gif.sh ./

CMD ./asc-to-gif.sh $SRC $DST
