FROM ubuntu:22.10

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

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
    python3-pyqt5.qtsvg \
    libreadline6-dev \
 && rm -rf /var/lib/apt/lists/*

# Install EPICS
RUN mkdir -p /usr/local/src/epics/base-7.0.7
WORKDIR /usr/local/src/epics/base-7.0.7
RUN wget -c base-7.0.7.tar.gz https://github.com/epics-base/epics-base/archive/R7.0.7.tar.gz -O - | tar zx --strip 1
RUN make clean && make && make install
ENV EPICS_BASE /usr/local/src/epics/base-7.0.7
ENV PATH $PATH:$EPICS_BASE/bin/linux-x86_64
RUN echo /usr/local/lib >> /etc/ld.so.conf.d/rogue_epics.conf
RUN echo $EPICS_BASE/lib/linux-x86_64 >> /etc/ld.so.conf.d/rogue_epics.conf
RUN ldconfig

# Install PCAS
RUN mkdir -p /usr/local/src/pcas/pcas-4.13.3
WORKDIR /usr/local/src/pcas/pcas-4.13.3
RUN wget -c pcas-4.13.3.tar.gz https://github.com/epics-modules/pcas/archive/v4.13.3.tar.gz -O - | tar zx --strip 1
RUN echo "EPICS_BASE = ${EPICS_BASE}" >> configure/RELEASE
RUN make INSTALL_LOCATION=$EPICS_BASE/pcas
ENV EPICS_PCAS_ROOT $EPICS_BASE/pcas
ENV PATH $PATH:$EPICS_PCAS_ROOT/bin/linux-x86_64
RUN echo $EPICS_PCAS_ROOT/lib/linux-x86_64 >> /etc/ld.so.conf.d/rogue_epics.conf
RUN ldconfig

# PIP Packages
RUN pip3 install PyYAML parse click ipython pyzmq packaging matplotlib numpy pyepics p4p pydm jsonpickle sqlalchemy pyserial

# Return to a neutral directory
WORKDIR /root
