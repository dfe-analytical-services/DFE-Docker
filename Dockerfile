FROM ubuntu:latest


# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    gdal-bin \
    libgdal-dev \
    proj-bin \
    libproj-dev \
    libudunits2-dev \
    wget \
    gnupg2 \
    ca-certificates \
    libfontconfig1-dev \
    libfreetype6-dev \
    pkg-config \
    yq \
    curl \
    libcurl4-openssl-dev \
    gir1.2-harfbuzz-0.0 \
    chromium-browser \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libxcomposite-dev \
    libxdamage1 \
    libxrandr2 \
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
    
RUN wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub && \
    gpg --no-default-keyring --keyring /etc/apt/keyrings/google-chrome.gpg --import /tmp/google.pub && \
    echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install \
    google-chrome-stable && \    
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
