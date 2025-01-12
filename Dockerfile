FROM --platform=$BUILDPLATFORM ghcr.io/planetary-server-manager/planetary-steam-base:latest AS build
ARG TARGETOS
ARG TARGETARCH

LABEL maintainer="renegadespork"

EXPOSE 30000-30004/udp 30000-30004/tcp

# Install Wine
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install wget -y
RUN mkdir -pm755 /etc/apt/keyrings
RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources
RUN apt-get update
RUN apt-get install --install-recommends wine-stable -y

RUN mkdir /config

COPY /scripts /scripts

# Fix permissions
RUN usermod -l empyrion ubuntu
RUN chmod -R 770 /scripts && \
    chmod -R 770 /config

RUN chown -R empyrion /scripts && \
    chown -R empyrion /config

USER empyrion

CMD ["/bin/bash", "/scripts/bootstrap.sh"]