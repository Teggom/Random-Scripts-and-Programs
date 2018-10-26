setwd("~/../Desktop/Music to Pic/")
if(!("png" %in% installed.packages())){install.packages("png");library("png")}else{library("png")}
if(!("abind" %in% installed.packages())){install.packages("abind");library("abind")}else{library("abind")}
Input <- read.table(file = "CutAudio.wav",sep = '017')


my.file <- file("uncomp.aiff", "rb")
id <- integer(0)
response <- character(0)
IDvals = readBin(my.file, integer(), size=4, endian = "little")
input <- c()
string <- c()
for(x in 1:800000){
  input <- c(input, charToRaw(readChar(my.file, nchars = 1)))
  if(x%%1000==0){print(x)}
  if(length(input)==5000){
    string <- c(input, string)
    input <- c()
  }
}
string <- string[1:750000]
string <- strtoi(paste("0x", as.character(string), sep = ""))/255

picr <- matrix(string[(1:250000)], nrow = 500, ncol = 500)
picg <- matrix(string[(250001:500000)], nrow = 500, ncol = 500)
picb <- matrix(string[(500001:750000)], nrow = 500, ncol = 500)
pic <- abind(picr, picg, picb, along = 3)
writePNG(image = pic, target = "comb4.png")
PicR <- matrix(string[(1:250000)*3-2], nrow = 500, ncol = 500)
PicG <- matrix(string[(1:250000)*3-1], nrow = 500, ncol = 500)
PicB <- matrix(string[(1:250000)*3], nrow = 500, ncol = 500)
Pic <- abind(PicR, PicG, along = 3)
Pic <- abind(Pic, PicB, along = 3)
writePNG(image = Pic, target = "spot5.png")


Picture <- matrix(string[1:749956], nrow = 866, ncol = 866)
writePNG(image = Picture, target = "Grey1.png")
#piR <- matrix(string[1:100000], nrow = 1000, ncol = 1000)
#piG <- matrix(string[100001:200000], nrow = 1000, ncol = 1000)
#piB <- matrix(string[200001:300000], nrow = 1000, ncol = 1000)
#pic <- abind(piR, piG, along = 3)
#pic <- abind(pic, piB, along = 3)
#
#writePNG(image = pic, target = "Conb4.png")




# Too Big
#PicR <- matrix(string[(1:2073600)*3-2], nrow = 1920, ncol = 1080)
#PicG <- matrix(string[(1:2073600)*3-1], nrow = 1920, ncol = 1080)
#PicB <- matrix(string[(1:2073600)*3], nrow = 1920, ncol = 1080)
#Pic <- abind(PicR, PicG, along = 3)
#Pic <- abind(Pic, PicB, along = 3)
#writePNG(image = as.matrix(Pic), target = "Spot1.png")