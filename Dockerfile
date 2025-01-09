FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Update and install fundamental packages
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        sudo \
        gdal-bin \
        libgdal-dev \
        proj-bin \
        libproj-dev \
        libudunits2-dev \
        wget \
        ca-certificates

# 2. Enable the Universe repository (needed for yq and other packages),
RUN add-apt-repository -y universe && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
        yq \
        curl \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev

# 3. Clean up package caches
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 4. Create a non-root user for github actions
RUN useradd -m github-actions
USER github-actions

ENTRYPOINT ["/bin/bash"]
