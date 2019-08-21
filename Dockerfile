FROM debian:10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y  build-essential git vim cmake wget curl python3  && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p build /opt
RUN cd build

COPY build.sh .

RUN ARCH=linux_x86_64 TRAVIS_TAG=docker bash build.sh && \
    rm -rf input && \
    mv output/fomu-toolchain-linux_x86_64-docker /opt && \
    rm -rf output

ENV PATH=/opt/fomu-toolchain-linux_x86_64-docker/bin:$PATH
