#!/bin/bash

cd ~/
git clone https://github.com/xmrig/xmrig.git
cd xmrig
mkdir build
cd build
cmake .. -DCMAKE_C_COMPILER=gcc-7 -DCMAKE_CXX_COMPILER=g++-7 -DWITH_HTTPD=OFF
make

echo "USERNAME is set to $USERNAME"
echo "ALGORITHM is set to $ALGORITHM"
echo "URL is set to $URL"

L3CACHE_KB=$(lscpu | grep -e '^L3' | tr -s ' ' | cut -d' ' -f3 | tr -d 'K')
L3CACHE_MB=$(($L3CACHE_KB/1024))
echo "Found $L3CACHE_MB MB L3 cache"

NUM_SOCKETS=$(cat /proc/cpuinfo | grep "physical id" | sort -u | wc -l)
echo "Found $NUM_SOCKETS sockets"

NUM_CPUS=$(nproc)
echo "Found $NUM_CPUS CPUs"

if [ -z ${THREADS+x} ]; then
  THREADS=$(($L3CACHE_MB*$NUM_SOCKETS/2))
  echo "THREADS based on (L3 MB * sockets / 2 MB) calculation -- $L3CACHE_MB MB * $NUM_SOCKETS / 2 MB = $THREADS"
  THREADS=$(($THREADS<$NUM_CPUS?$THREADS:$NUM_CPUS+1))
  echo "THREADS is set it to $THREADS"
else
  echo "THREADS is set to $THREADS"
fi

nice -n $PRIORITY ./xmrig -a $ALGORITHM -o $URL -u $USERNAME -p $PASSWORD -t $THREADS --donate-level=$DONATE -k
