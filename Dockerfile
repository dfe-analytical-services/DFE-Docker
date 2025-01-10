FROM rocker/r-ver:4.4.2

ENV DEBIAN_FRONTEND=noninteractive
ENV RENV_PACKAGE_TYPE=binary

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
        ca-certificates \
        libfontconfig1-dev \
        libfreetype6-dev \
        pkg-config

# 2. Enable the Universe repository (needed for yq and other packages),
RUN add-apt-repository -y universe && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
        yq \
        curl \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev

# 3. Configure R to use CRAN binaries
RUN echo 'options(repos = c(CRAN = "https://cloud.r-project.org"))' >> /usr/local/lib/R/etc/Rprofile.site 

# 4. Install renv globally
RUN R -e "install.packages('renv', repos = 'https://cloud.r-project.org')"

# 5. Clean up package caches
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ENTRYPOINT ["/bin/bash"]
