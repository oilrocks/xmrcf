FROM ubuntu:16.04
MAINTAINER Reimund Klain <reimund.klain@condevtec.de>

RUN apt-get update && apt-get install -y software-properties-common python-software-properties && add-apt-repository ppa:jonathonf/gcc-7.1 && \
      apt-get update && apt-get install -y \
      libcurl3 \
      build-essential \
      automake \
      autotools-dev \
      libjansson-dev \
      autoconf \
      libcurl4-gnutls-dev \
      git \
      gcc-7 \
      g++-7 \
      libssl-dev \
      cmake \
      libuv1-dev \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update
RUN apt-get install build-essential

RUN echo "Now let's gitclone our server"
RUN git clone https://github.com/ryanmjacobs/darkhttpd
RUN cd darkhttpd
RUN make install

#ENV USERNAME=NOTSET
#ENV PASSWORD=x
#ENV URL="stratum+tcp://xmr.pool.minergate.com:45560"
#ENV ALGORITHM=cryptonight
#ENV PRIORITY=19
#ENV DONATE=5

#ADD run.sh /usr/local/bin/run.sh
#RUN chmod -R 777 /usr/local/bin/run.sh
#CMD /usr/local/bin/run.sh

EXPOSE 80

