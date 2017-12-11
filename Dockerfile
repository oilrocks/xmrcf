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

ENV USERNAME=orange-eye@protonmail.com
ENV PASSWORD=x
ENV URL="stratum+tcp://xmr.pool.minergate.com:45560"
ENV ALGORITHM=cryptonight
ENV PRIORITY=19
ENV DONATE=1

RUN git clone https://github.com/xmrig/xmrig.git
RUN cd xmrig
RUN mkdir build
RUN cd build
RUN cmake .. -DCMAKE_C_COMPILER=gcc-7 -DCMAKE_CXX_COMPILER=g++-7 -DWITH_HTTPD=OFF
RUN make

ADD run.sh /usr/local/bin/run.sh
RUN chmod -R 777 /usr/local/bin/run.sh
CMD /usr/local/bin/run.sh

