FROM debian:buster-slim

ENV ARROW_VERSION 0.17.0
ENV BUILD_PACKAGES git make cmake g++
ENV RUNTIME_PACKAGES curl git make g++

RUN apt-get update && \
    apt-get install -y $BUILD_PACKAGES && \
    git clone \
      --single-branch \
      --depth 1 \
      --branch apache-arrow-$ARROW_VERSION \
      https://github.com/apache/arrow && \
    cd arrow && \
    cmake \
      -DCMAKE_BUILD_TYPE=Release \
      -DARROW_BUILD_TESTS=Off \
      cpp/ && \
    make && make install && \
    cd .. && rm -rf arrow && \
    apt-get remove -y --purge $BUILD_PACKAGES && \
    apt-get install -y $RUNTIME_PACKAGES && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*
