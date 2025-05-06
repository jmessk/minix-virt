FROM ubuntu:jammy-20250415.1

RUN apt-get update && apt-get install -y \
    build-essential

COPY ./setuptools /var/tmp/setuptools

WORKDIR /var/tmp/setuptools
RUN make install
RUN rm -rf /var/tmp/setuptools

ARG UID
ARG GID

RUN groupadd -g ${GID} user && \
    useradd -m -s /bin/bash -u ${UID} -g ${GID} user

USER user
WORKDIR /home/user
