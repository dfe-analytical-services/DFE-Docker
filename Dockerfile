FROM ubuntu:latest

# Set environment variables to ensure non-interactive installations
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

# 2. Enable the Universe repository (needed for yq), then install yq
RUN add-apt-repository -y universe && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends yq

# 3. Add the libgit2 PPA for newer libgit2, then install dependencies
RUN add-apt-repository -y ppa:cran/libgit2 && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
        curl \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev

# 4. Clean up package caches
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 5. Create a user for GitHub Actions
RUN useradd -m github-actions
USER github-actions

# 6. Set an entrypoint
ENTRYPOINT ["/bin/bash"]
