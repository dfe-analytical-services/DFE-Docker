# This script pre-installs common dashboard R packages on the Docker image with the aim of speeding up deploys.
library(shiny)
library(shinytest2)

library(reactable)
library(ggplot2)
library(ggiraph)

library(dplyr)
library(readr)
library(tidyr)

library(shinyGovstyle)
library(dfeR)

library(rmarkdown)
library(quarto)
