# This program is designed to provide pointer implementation to an R user. 

Pointers <- new.env()

`%&%` = function(x,y){
  Pointers[[as.character(substitute(x))]] <<- y
}

`.D` = function(x, ...){
  return(Pointers[[as.character(substitute(x))]])
}

`.E` = function(x, ...){
  return(Pointers[[x]])
}