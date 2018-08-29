FROM alpine:3.8

ENV ARROW_VERSION 0.10.0

ENV BUILD_PACKAGES git make cmake g++
ENV RUNTIME_PACKAGES boost-dev

RUN apk add --no-cache $BUILD_PACKAGES $RUNTIME_PACKAGES && \
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
    apk del $BUILD_PACKAGES
