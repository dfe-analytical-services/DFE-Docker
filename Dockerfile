FROM ubuntu:22.04

# Set environment variables to ensure non-interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install dependencies
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        sudo \
        gdal-bin \
        libgdal-dev \
        proj-bin \
        libproj-dev \
        libudunits2-dev \
        yq \
        wget \
        software-properties-common && \
        add-apt-repository -y ppa:cran/libgit2 && \
        apt-get update -y && \
        apt-get install -y --no-install-recommends \
        curl \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev


# Install renv for R
RUN R -e "if (!requireNamespace('renv', quietly = TRUE)) install.packages('renv', repos='https://cloud.r-project.org')"

# Clean up unnecessary files
RUN apt-get clean && rm -rf /tmp/* /var/tmp/*

# Create a user for GitHub Actions
RUN useradd -m github-actions
USER github-actions

# Add an entrypoint (optional, if required)
ENTRYPOINT ["/bin/bash"]
