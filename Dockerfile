FROM ubuntu:latest


# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    gdal-bin \
    libgdal-dev \
    proj-bin \
    libproj-dev \
    libudunits2-dev \
    wget \
    ca-certificates \
    libfontconfig1-dev \
    libfreetype6-dev \
    pkg-config \
    yq \
    curl \
    libcurl4-openssl-dev \
    gir1.2-harfbuzz-0.0 \
    libatk1.0-0 \
    libfribidi-dev \
    libgraphite2-dev \
    libharfbuzz-dev \
    libharfbuzz-gobject0 \
    libharfbuzz-icu0 \
    libgit2-dev \
    libssl-dev \
    libtiff5-dev \
    libxml2-dev \
    glpk-utils \
    libglpk-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
