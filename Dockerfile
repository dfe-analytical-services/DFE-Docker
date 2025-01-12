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
    libssl-dev \
    libxml2-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
