FROM julia

WORKDIR /home

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -yq dist-upgrade \
 && apt-get install -yq --no-install-recommends \
    ca-certificates \
    locales \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

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
