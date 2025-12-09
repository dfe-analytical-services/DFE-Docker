FROM ubuntu:latest

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    locales \
    gdal-bin \
    libgdal-dev \
    proj-bin \
    libproj-dev \
    libudunits2-dev \
    wget \
    curl \
    git \
    gnupg2 \
    ca-certificates \
    libfontconfig1-dev \
    libfreetype6-dev \
    pkg-config \
    yq \
    curl \
    language-pack-en-base \
    libcurl4-openssl-dev \
    gir1.2-harfbuzz-0.0 \
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
    libcairo2-dev \
    libglpk-dev \
    libabsl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Some packages required by s2 as flagged in LSIP dashboard fail
RUN apt-get install libabsl-dev
RUN dnf install abseil-cpp-devel
RUN brew install abseil

# I was getting some issues with pound symbols in shinytest on GH Actions, suspect this is down to 
# the wrong locale being set, so setting to GB here.
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_GB.UTF-8  
ENV LANGUAGE en_GB:en  
ENV LC_ALL en_GB.UTF-8

# Install chrome so that shinytest2 can run
RUN wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub && \
    gpg --no-default-keyring --keyring /etc/apt/keyrings/google-chrome.gpg --import /tmp/google.pub && \
    echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    google-chrome-stable && \    
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
