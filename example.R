
#' @title Add two number
#' @description A short description...
#'     (if the line feed, there should be four space before a new line)
#'     !!!Don't start with 'This package' or 'This function'
#'     
#' @details More detailed descriptions
#' @param x The explanation of the first param
#' @param y The explanation of the second param
#'
#' @return Get what through the function
#' @export
#' @importFrom base sum
#' @examples add(1,2)
#' \donttest{
#' add(3,4)}
#'

#cite other package from CRAN
#usethis::use_package(package="stats",type="Imports")#cite Imports function
#usethis::use_package(package="stats",type="Depends")#cite all functions in stats
#if want to cite packages on bioconductor: in Descriptions
#biocViews:
#Imports:
#    limma

add<-function(x,y){
  x+y
}
#insert annotations
#1.put the mouse in the function
#2.Code-> Insert Roxygen Skeleton
#cite other package->@importFrom package function
#Or write{ package::function() } in the main function
#\donttest{} : ignore the examples when tested
#after write the document:devtools::document()
#enclose package:devtools::build()
#change author in description'person(given = "Yifan",family = "Yue", email = "yifanyue@outlook.com", role= "aut")'
#change version in description
