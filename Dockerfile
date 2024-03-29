FROM ubuntu:xenial


RUN apt-get update \
     && apt-get install -y wget \
     && rm -rf /var/lib/apt/lists/* 


WORKDIR "/opt"
ARG BINARY="geth-alltools-linux-amd64-1.8.1-1e67410e.tar.gz"
RUN wget "https://gethstore.blob.core.windows.net/builds/$BINARY"
RUN tar -xzvf $BINARY --strip 1
RUN rm $BINARY


ADD . .
ADD ./genesis.json ./genesis.json 
RUN mkdir node
RUN ./geth --datadir ./node init genesis.json

CMD exec ./geth --networkid 19901437325 --verbosity=4 --rpcport 5545 --rpc --rpcaddr "172.17.0.1" --rpccorsdomain "*" --rpcapi "admin,db,eth,net,web3,personal,miner,txpool" --datadir ./node --rpccorsdomain "*" --ws --wsport 6545 --wsorigins=* --wsapi db,eth,net,ssh,miner,web3,personal,admin,txpool --rpcvhosts=* --mine --minerthreads 1 --etherbase 0x82A7FC1C127A04Bf1e261d71055c07eD5AD28855

EXPOSE 5545
EXPOSE 6545
EXPOSE 30303
