# FROM ubuntu:jammy-20250415.1
FROM rust:1.86.0-bookworm

RUN apt-get update && apt-get install -y \
    build-essential \
    bsdmainutils

COPY ./setuptools /var/tmp/setuptools

WORKDIR /var/tmp/setuptools

RUN make && \ 
    make install && \
    make setup

RUN rm -rf /var/tmp/setuptools

ARG UID
ARG GID

RUN groupadd -g ${GID} user && \
    useradd -m -s /bin/bash -u ${UID} -g ${GID} user

USER user
WORKDIR /home/user
