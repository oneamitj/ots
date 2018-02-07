FROM ubuntu:16.04

# add bitcoind from the official PPA
RUN sed -i 's|http://archive|http://np.archive|g' /etc/apt/sources.list
# RUN cat /etc/apt/sources.list
RUN apt-get update
# RUN apt-get install --yes software-properties-common
# RUN add-apt-repository --yes ppa:bitcoin/bitcoin
# RUN apt-get update

# install bitcoind (from PPA) and make
# RUN apt-get install --yes bitcoind make

RUN apt-get install --yes software-properties-common
RUN add-apt-repository --yes ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get install --yes python3-pip
RUN apt-get install --yes git
RUN apt-get install --yes bitcoind bitcoin-tx


WORKDIR /root

# OTS Server
RUN git clone https://github.com/opentimestamps/opentimestamps-server.git
RUN pip3 install -r opentimestamps-server/requirements.txt
RUN mkdir -p /root/.otsd/calendar/
RUN echo "http://127.0.0.1:14788" > /root/.otsd/calendar/uri
WORKDIR /root/.otsd/calendar/
RUN dd if=/dev/random of=/root/.otsd/calendar/hmac-key bs=32 count=1

WORKDIR /root
# OTS Client
RUN pip3 install opentimestamps opentimestamps-client

RUN git clone https://github.com/opentimestamps/opentimestamps-client.git
RUN pip3 install -r opentimestamps-client/requirements.txt
# RUN git clone https://github.com/opentimestamps/python-opentimestamps.git

RUN mkdir -p /root/.bitcoin/regtest
RUN mkdir -p /root/miner/regtest
COPY ./regtest /root/.bitcoin/regtest
COPY ./regtest /root/miner/regtest
COPY ./bitcoin_admin.conf /root/.bitcoin/bitcoin.conf
COPY ./bitcoin_miner.conf /root/miner/bitcoin.conf

CMD ["bitcoind"]
