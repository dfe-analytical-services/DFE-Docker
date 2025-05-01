FROM r-base:4.4.2

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    locales && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# I was getting some issues with pound symbols in shinytest on GH Actions, suspect this is down to 
# the wrong locale being set, so setting to GB here.
RUN sed -i '/en_GB.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_GB.UTF-8  
ENV LANGUAGE en_GB:en  
ENV LC_ALL en_GB.UTF-8

RUN pwd

RUN ls

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gdal-bin \
    libgdal-dev \
    proj-bin \
    libproj-dev \
    libudunits2-dev \
    wget \
    curl \
    gnupg2 \
    ca-certificates \
    libfontconfig1-dev \
    libfreetype6-dev \
    pkg-config \
    yq \
    curl \
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
    libglpk-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Posit Air for code styling
RUN curl -LsSf https://github.com/posit-dev/air/releases/latest/download/air-installer.sh | sh

# Add latest R packages to renv cache
COPY r-setup r-setup

WORKDIR /r-setup
CMD Rscript R/update-packages.R
WORKDIR /
