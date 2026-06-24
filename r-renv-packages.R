# Package set up
renv::init()
renv::snapshot(
   c(
      "dfe-analytical-services/dfeshiny", 
      "dfe-analytical-services/dfeR", 
      "dfe-analytical-services/eesyapi", 
      "dfe-analytical-services/eesyscreener", 
      "dfe-analytical-services/shinyGovstyle",
      "shiny",
      "terra",
      "sf"
   )
)
renv::restore()
