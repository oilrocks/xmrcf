The container supports multiple pools, username, password by environment varibales.
Container is preconfigured for Minergate.com and optimized for Cloud foundry based platforms 
Miner will be compiled at start time to get best out of your CPU arch.

# Environment Variables with defaults

* USERNAME=(mandatory)
* PASSWORD=x (default: x)
* URL=xmr.pool.minergate.com:45560 (default: Minergate)
* PRIORITY=19 (defaule: nice value)
* THREADS= (default: calculated by available CPUs or (L3 cache * sockets / 2) Note: smaller value wins
* DONATE=1 (1% to XMRig team)

# Pools
The container supports different pools by environment variable URL

# Minergate
```
docker run -d -e USERNAME=username condevtec/xmr-miner-cpu
```

# Other Pools
```
docker run -d -e USERNAME=otherpool-username -e PASSWORD=otherpool-password -e URL=otherpool.url:port condevtec/xmr-miner-cpu
```

# Fix Threads
```
docker run -d -e USERNAME=username -e THREADS=4 condevtec/xmr-miner-cpu
```
