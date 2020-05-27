FROM julia:1.4.0

WORKDIR /home

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -yq dist-upgrade \
 && apt-get install -yq --no-install-recommends \
    ca-certificates \
    locales \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# always use latest pip
RUN /usr/local/bin/python -m pip install --upgrade pip

# set locale
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# install packages "globally"
ENV JULIA_DEPOT_PATH /opt/julia-packages/
COPY install.jl /tmp/install.jl
RUN julia /tmp/install.jl
