if(!("png" %in% installed.packages())){install.packages("png");library("png")}else{library("png")}
if(!("jpeg" %in% installed.packages())){install.packages("jpeg");library("jpeg")}else{library("jpeg")}
if(!("dplyr" %in% installed.packages())){install.packages("dplyr");library("dplyr")}else{library("dplyr")}
if(!("imager" %in% installed.packages())){install.packages("imager");library("imager")}else{library("imager")}
setwd("~/Raw/")

#Splice up photos
cut_size <- 30
cut_cut <- cut_size/2
picture_Raws <- list()
picture_Names <- list()
for(x in dir()){
  picture_Raws[[length(picture_Raws)+1]] <- paste("~/Raw/", x, sep = "")
  picture_Names[[length(picture_Names)+1]] <- gsub("\\.jpg$", "", x)
}
setwd("../Splinter/")
for(x in 1:length(picture_Raws)){
  Type <- ""
  if(grepl("\\.jpg", picture_Raws[[x]])){
    Picture <- readJPEG(picture_Raws[[x]])[,,1:3]
    Type <- "J"
  } else if(grepl("\\.png", picture_Raws[[x]])){
    Picture <- readPNG(picture_Raws[[x]])[,,1:3]
    Type <- "P"
  } else {
    print(paste("Failed on", picture_Names[[x]]))
    break
  }
  if(length(Picture[1,,1])!=1920 || length(Picture[,1,1])!=1080){
    print(paste("Invalid dimensions for", picture_Names[[x]]))
    break
  }
  
  for(col in 1:(1920/cut_cut-1)){
    for(row in 1:(1080/cut_cut-1)){
      splice <- Picture[((row*cut_cut)-cut_cut+1):((row*cut_cut)+cut_cut), ((col*cut_cut)-cut_cut+1):((col*cut_cut)+cut_cut),]
      if(Type=="J")
        writeJPEG(image = splice, target = paste(picture_Names[[x]], "_", row, "-", col, "_To_", row+cut_size, "-", col+cut_size, " splice.jpg", sep = ""))
      if(Type=="P")    
        writePNG(image = splice, target = paste(picture_Names[[x]], "_", row, "-", col, "_To_", row+cut_size, "-", col+cut_size, " splice.png", sep = ""))
    }
    print(paste(picture_Names[[x]], ": Col", col, "of", (1920/(cut_size/2)-1)))
  }
  
}



#Create special training directory
selections <- sample(x = 2:length(dir()), size = length(dir())-1, replace = F)
im <- load.image(dir()[1])
reim <- resize(im, round(width(im)*2/3), round(height(im)*2/3))
flatIm <- c()
flatReIm <- c()
for(color in 1:3){
  flatIm <- c(flatIm, im[,,color])
  flatReIm <- c(flatReIm, reim[,,color])
}
training <- c(flatReIm, flatIm)
table <- data.frame(training)
counter <- 2
training <- c(flatReIm, flatIm)
for(x in selections){
  im <- load.image(dir()[x])
  reim <- resize(im, round(width(im)*2/3), round(height(im)*2/3))
  flatIm <- c()
  flatReIm <- c()
  for(color in 1:3){
    flatIm <- c(flatIm, im[,,color])
    flatReIm <- c(flatReIm, reim[,,color])
  }
  training <- c(flatReIm, flatIm)
  tryCatch(expr = {
    newT <- data.frame(training)
    table <- dplyr::bind_cols(table, newT)
    print("Adding to table")
    },error = function(x){
      table <- data.frame(training)
      print("Creating Table")
    })
  print(paste("On ", counter, " of ", length(selections)+1, sep = ""))
  counter <- counter + 1
  if(counter%%1000==0){
    print(paste("Saving"))
    write.csv(x = table, file = paste("G:/Table/", counter, ".csv", sep = ""))
  }
}



