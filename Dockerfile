FROM ubuntu:18.04

# Install system tools
RUN apt-get update && apt-get install -y \
    wget \
    git \
    iputils-ping \
    cmake \
    python3 \
    python3-dev \
    libboost-all-dev \
    libbz2-dev \
    python3-pip \
    libzmq3-dev \
    python3-pyqt5 \
    libreadline6-dev \
 && rm -rf /var/lib/apt/lists/*

# Install EPICS
RUN mkdir -p /usr/local/src/epics/base-3.15.5
WORKDIR /usr/local/src/epics/base-3.15.5
RUN wget -c base-3.15.5.tar.gz https://github.com/epics-base/epics-base/archive/R3.15.5.tar.gz -O - | tar zx --strip 1
RUN make clean && make && make install
ENV EPICS_BASE /usr/local/src/epics/base-3.15.5

# PIP Packages
RUN pip3 install PyYAML Pyro4 parse click ipython pyzmq packaging matplotlib numpy pyepics
