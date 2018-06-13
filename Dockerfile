FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -y imagemagick bash qrencode zbar-tools

ADD asc-to-gif.sh ./

CMD ./asc-to-gif.sh $SRC $DST
