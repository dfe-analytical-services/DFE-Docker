# Package set up
renv::init()
renv::record(
  c(
    "renv",
    "dfe-analytical-services/dfeshiny",
    "dfe-analytical-services/dfeR",
    "dfe-analytical-services/eesyapi",
    "dfe-analytical-services/eesyscreener",
    "dfe-analytical-services/shinyGovstyle",
    "shiny",
    "shinytest2",
    "terra",
    "sf"
  )
)
renv::restore()
renv::snapshot()
