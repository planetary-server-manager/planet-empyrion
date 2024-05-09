FROM ubuntu:latest

LABEL maintainer="thekraken8him"

ENV TIMEZONE=America/Los_Angeles \
    PUID=0 \
    PGID=0

EXPOSE 30000-30004/udp 30000-30004/tcp

# Install Wine
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install software-properties-common apt-transport-https curl wget -y
RUN mkdir -pm755 /etc/apt/keyrings
RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources
RUN apt-get update
RUN apt-get install --install-recommends wine-stable -y

RUN mkdir /steam
RUN mkdir /server
RUN mkdir /saves
RUN mkdir /config

RUN cd /steam
RUN add-apt-repository multiverse
RUN apt-get update
RUN install steamcmd -y

COPY server.sh server.sh
COPY generate-map.sh generate-map.sh
COPY logo.txt logo.txt

RUN chmod +x server.sh
RUN chmod +x generate-map.sh

CMD ["/bin/bash", "server.sh"]