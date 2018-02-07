# OTS Usage

- Start container with bitcoin daemon

        docker run -d --name otscontainer ots

- Access otscontainer bash

        docker exec -it otscontainer bash

- All task is done within container
- Open multiple otscontainer bash instance each for `OTSserver`, `OTSclient` and `bitcoin-cli`

- Start miner daemon

        bitcoind -datadir=/root/miner -daemon

- Accumulate some coins in admin node

        bitcoin-cli generate 101

- Start OTS local server on one bash
    
        ./otsd --btc-regtest --btc-min-confirmations 3 --btc-min-tx-interval 60

- TimeStamp FILE in another bash
    
        ots --wait --verbose stamp -c http://localhost:14788 -m 1 FILE

- Generate Blocks for timestamp in third bash using miner account
    
        bitcoin-cli -datadir=/root/miner generate 3

- Upgrade if --wait is not used (sync bitcoin chain)
    
        ots --btc-regtest -l http://127.0.0.1:14788 upgrade FILE.ots 

- Verify Timestamp
    
        ots --btc-regtest -l http://127.0.0.1:14788 verify FILE.ots
