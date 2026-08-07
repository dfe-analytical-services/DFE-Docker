FROM rocker/r-ver:4

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    wget \
    locales \
    gdal-bin \
    libgdal-dev \
    proj-bin \
    libproj-dev \
    libudunits2-dev \
    ca-certificates \
    chromium \
    cmake \
    curl \
    gir1.2-harfbuzz-0.0 \
    git \
    glpk-utils \
    gnupg2 \
    language-pack-en-base \
    libabsl-dev \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libgit2-dev \
    libgraphite2-dev \
    libglpk-dev \
    libharfbuzz-dev \
    libharfbuzz-gobject0 \
    libharfbuzz-icu0 \
    libssl-dev \
    libtiff5-dev \
    libuv1-dev \
    libxcomposite-dev \
    libxdamage1 \
    libxml2-dev \
    libxrandr2 \
    pkg-config \
    yq \
    pandoc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install chrome headless browser dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \ 
    libasound2t64 \
    libnspr4 \
    libnss3 \
    libxkbcommon-x11-0 \
    libxss1 \
    xdg-utils \
    unzip \
    fonts-liberation \
    chromium-browser && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
# I was getting some issues with pound symbols in shinytest on GH Actions, suspect this is down to 
# the wrong locale being set, so setting to GB here.
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_GB.UTF-8  
ENV LANGUAGE en_GB:en  
ENV LC_ALL en_GB.UTF-8

RUN R -e "install.packages(c('renv'),dependencies=TRUE, repos='http://cran.rstudio.com/')"

# From https://rstudio.github.io/renv/articles/docker.html
RUN mkdir -p renv

# copy renv infrastructure
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

# set path to the renv package cache
ENV RENV_PATHS_CACHE=/renv/cache

# ensure packages are copied, not symlinked
ENV RENV_CONFIG_CACHE_SYMLINKS=FALSE

# restore with mounted cache
RUN --mount=type=cache,target=/renv/cache \
    R -s -e "renv::restore()"
    
