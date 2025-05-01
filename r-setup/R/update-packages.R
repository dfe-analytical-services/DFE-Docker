# This runs renv to add the latest versions of all the packages to the docker cache
install.packages("renv")
renv::init()
renv::restore()
renv::update()
renv::snapshot()

