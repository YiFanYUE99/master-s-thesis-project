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
#3 not the same name as existing packages

#make my package
usethis::create_package("meTool",open = T)# no opening new project
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

#build a website for the package
#devtools::build_site()

#make package
devtools::build()
#annotations

#cite other package from CRAN
#check thepackage
devtools::check()

#add related package to import
#everytime add an usethis,retype : devtools::document()
usethis::use_package("aplot")
usethis::use_package("cowplot")
usethis::use_package("patchwork")
usethis::use_package("tidyverse", type="depends")
usethis::use_package("ggplotify")
usethis::use_package("psych")
usethis::use_package("tidygraph")
usethis::use_package("ggraph")
usethis::use_package("igraph")
usethis::use_package("ggplot2")
usethis::use_package("dplyr")
usethis::use_package("rstatix")
usethis::use_package("linkET")
usethis::use_package("devtools")
usethis::use_package("ggDoubleHeat")

#为单个函数添加注释
#Ctrl+Shift+Alt+R




