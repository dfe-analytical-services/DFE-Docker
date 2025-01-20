# DfE R Base Docker Image

This repository contains the base Docker image used by the [DfE Shiny deployment script](https://github.com.mcas.ms/dfe-analytical-services/dfeshiny/blob/main/.github/workflows/dashboard_deploy_template.yaml). The image is designed to include essential Linux libraries and R dependencies required for deploying Shiny apps efficiently without the need to install these dependencies during pipeline runtime.

## Purpose

The primary goal of this Docker image is to:
- Pre-install key Linux libraries and R dependencies to minimize build time during deployment.
- Serve as the container environment for running the deployment workflows defined in the `dfeshiny` template repository.
- Ensure consistency and reliability across deployment environments.

## Key Features

- Based on the `ubuntu:latest` image.
- Pre-installed libraries:
  - GDAL (`gdal-bin`, `libgdal-dev`)
  - PROJ (`proj-bin`, `libproj-dev`)
  - Other utilities (`yq`, `curl`, `wget`, etc.)
- Published to GitHub Container Registry (GHCR) for easy integration with GitHub Actions workflows.

## Maintenance Guide

### Adding New Dependencies
If you need to add or update the dependencies included in the Docker image:
1. Modify the `Dockerfile` to include the required package or library. For example:
   ```dockerfile
   RUN apt-get update && apt-get install -y --no-install-recommends \
       new-package-name
   ```
2. Build the updated Docker image locally to test:
   ```bash
   docker build -t your-local-tag .
   ```
3. Push the changes to the repository and ensure the GitHub Actions workflow rebuilds and publishes the image.

### Maintaining Versioning
1. Ensure the `latest` tag in the GitHub Container Registry always points to the most up-to-date and stable version of the image.
2. For major changes, consider versioning the Docker image explicitly. Update the workflow to tag images with a version, e.g. `ghcr.io/dfe-analytical-services/dfe-r-base:1.0.0`.
3. Update any repositories using this image to reference the correct versioned tag to prevent breaking changes.

## Deployment

The Docker image is deployed to the [GitHub Container Registry](https://github.com.mcas.ms/orgs/dfe-analytical-services/packages):
- Image URL: `ghcr.io/dfe-analytical-services/dfe-r-base:latest`

This image is referenced directly in workflows as a base image:
```yaml
container:
  image: ghcr.io/dfe-analytical-services/dfe-r-base:latest
```

## Documentation for Users

### How to Use This Image
1. In your GitHub Actions workflow, specify this image under the `container` section.
2. Include any additional steps or dependencies required for your application after using this base image.

### Example Usage
The image is designed for use with the DfE Shiny deployment script. Below is an example of how it's integrated:
```yaml
jobs:
  deployShiny:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/dfe-analytical-services/dfe-r-base:latest
      options: --user root
    steps:
      - uses: actions/checkout@v4
      - uses: r-lib/actions/setup-r@v2
        with:
          use-public-rspm: true
```

### For Contributors
- When modifying the `Dockerfile`, ensure all changes are tested locally before committing.
- Follow semantic versioning for any breaking changes or significant updates.
