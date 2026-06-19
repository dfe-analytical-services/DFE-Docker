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
    chromium \
    cmake \
    curl \
    git \
    gnupg2 \
    ca-certificates \
    libfontconfig1-dev \
    libfreetype6-dev \
    pkg-config \
    yq \
    language-pack-en-base \
    libcurl4-openssl-dev \
    gir1.2-harfbuzz-0.0 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libxcomposite-dev \
    libxdamage1 \
    libxrandr2 \
    libfontconfig1-dev \
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
    libabsl-dev \
    libuv1-dev \
    pandoc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# I was getting some issues with pound symbols in shinytest on GH Actions, suspect this is down to 
# the wrong locale being set, so setting to GB here.
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_GB.UTF-8  
ENV LANGUAGE en_GB:en  
ENV LC_ALL en_GB.UTF-8

RUN apt install -y libssl-dev libxml2-dev libcurl4-openssl-dev
RUN apt install -y r-base

RUN R -e "install.packages(c('renv'),dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "renv::init()"
RUN R -e "renv::install(c('chromote', 'tidyverse', 'rsconnect', 'dfe-analyitcal-services/dfeshiny', 'dfe-analyitcal-services/shinyGovstyle'))"
