#install needed packages
install.packages("usethis")
install.packages("devtools")
install.packages("roxygen2")
library(usethis)
library(devtools)
library(roxygen2)

#check
has_devel()

#R package name rules:
#1 start with letter instead of number
#2 letters,numbers, and points only
#3 not te same name as existing packages

#make my package
usethis::create_package("meTool",open = F)# no opening new project
#R file in meTool file saves scripts
#no other folders in R file
#NAMESPACE don't change,it's important

#enclosure package: 1.build->document 2.build->install package
#Done : install successfully
library(meTool)

#write instructions
#control shift p: insert roxygen comment

#write annotations
devtools::document()
#make package
devtools::build()
#annotations

#cite other package from CRAN





