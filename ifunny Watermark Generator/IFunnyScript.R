
targetDir <- "~"
library('png')
library("abind")
SourceDir <- "~"
Mark <- readPNG("~/IFunnyWatermark.png")
setwd(SourceDir)
for(each in dir()){
  print(paste(each))
  setwd(SourceDir)
  if(grepl("\\.png$",ignore.case = T, each)){
    Pic <- readPNG(each)
    Pic <- Pic[,,1:3]
    marked <- ""
    if(ncol(Pic)==ncol(Mark)){
      Marked <- abind(Pic, Mark, along = 1)
    }
    else if(ncol(Pic) > ncol(Mark)){
      slice = Mark[,10,]
      while(ncol(Mark)<ncol(Pic)){
        Mark <- abind(slice, Mark, along = 2)
      }
      Marked <- abind(Pic, Mark, along = 1)
    }
    else if(ncol(Pic) < ncol(Mark)){
      Mark <- Mark[,(ncol(Mark)-ncol(Pic)+1):ncol(Mark),]
      Marked <- abind(Pic, Mark, along = 1)
    }
    setwd(targetDir)
    tryCatch({
      writePNG(image = Marked, target = paste("STUPID", each))
    }, error = function(x){})
  }
}

