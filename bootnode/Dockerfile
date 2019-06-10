FROM ubuntu:xenial


RUN apt-get update \
     && apt-get install -y wget \
     && rm -rf /var/lib/apt/lists/* 

WORKDIR "/opt"
ARG BINARY="geth-alltools-linux-amd64-1.8.1-1e67410e.tar.gz"
RUN wget "https://gethstore.blob.core.windows.net/builds/$BINARY"
RUN tar -xzvf $BINARY --strip 1
RUN rm $BINARY


ADD ./genesis.json ./genesis.json 
RUN mkdir node
RUN ./geth --datadir ./node init genesis.json

CMD exec ./geth --networkid 19901437325 --verbosity=4 --rpcport 5545 --rpc --rpcaddr "0.0.0.0" --rpccorsdomain "*" --rpcapi "admin,db,eth,net,web3,personal,miner,txpool" --datadir ./node --rpccorsdomain "*" --ws --wsport 6545 --wsorigins=* --wsapi db,eth,net,ssh,miner,web3,personal,admin,txpool --rpcvhosts=* --bootnodes "enode://a435484c5d0812264d38de6aaa1e6bbc54d1ac89fbbf592c1211832eb6d2714aaf65e5d6fd3bdcc58243d2620897e274f3d79c638b71c1c6f43ab3e44d0445bd@[138.68.73.246]:30303" --mine --minerthreads 1 --etherbase 0x9ec0744b6af495670cb710ba23d4e38bd1a8e53e


EXPOSE 5545
EXPOSE 6545
EXPOSE 30303
