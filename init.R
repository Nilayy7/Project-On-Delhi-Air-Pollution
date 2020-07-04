#
# Example R code to install packages
#

###########################################################
# Update this line with the R packages to install:

my_packages = c(
	"shinythemes","shinydashboard","shinycssloaders","forecast","padr","imputeTS","readxl","dplyr","DT","ggplot2","shinyWidgets"
)

###########################################################
install_if_missing = function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {
    install.packages(p)
  }
}

invisible(sapply(my_packages, install_if_missing))
