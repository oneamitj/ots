#OTS Usage

- Start BitCoin at ~/.bitcoin/regtest with ~/.bitcoin/bitcoin.conf

    bitcoind -daemon

- Start OTS local server 
    
    ./otsd --btc-regtest --btc-min-confirmations 3 --btc-min-tx-interval 60

- TimeStamp FILE
    
    ots --wait --verbose stamp -c http://localhost:14788 -m 1 FILE

- Generate Blocks for timestamp
    
    bitcoin-cli generate 101

- Upgrade if --wait is not used (sync bitcoin chain)
    
    ots --btc-regtest -l http://127.0.0.1:14788 upgrade FILE.ots 

- Verify Timestamp
    
    ots --btc-regtest -l http://127.0.0.1:14788 verify FILE.its
