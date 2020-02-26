FROM ubuntu:18.04

# Install system tools
RUN apt-get update && apt-get install -y \
    wget \
    git \
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
RUN mkdir -p /usr/local/src/epics/base-7.0.3
WORKDIR /usr/local/src/epics/base-7.0.3
RUN wget -c base-7.0.3.tar.gz https://github.com/epics-base/epics-base/archive/R7.0.3.tar.gz -O - | tar zx --strip 1
RUN make clean && make && make install
ENV EPICS_BASE /usr/local/src/epics/base-7.0.3

# Install PCAS
RUN mkdir -p /usr/local/src/pcas/pcas-4.13.2
WORKDIR /usr/local/src/pcas/pcas-4.13.2
RUN wget -c pcas-4.13.2.tar.gz https://github.com/epics-modules/pcas/archive/v4.13.2.tar.gz -O - | tar zx --strip 1
RUN make clean && make && make install
ENV EPICS_PCAS_ROOT /usr/local/src/pcas/pcas-4.13.2

# Install P4P

# PIP Packages
RUN pip3 install PyYAML Pyro4 parse click ipython pyzmq packaging matplotlib numpy pyepics p4p pydm jsonpickle sqlalchemy pyserial

