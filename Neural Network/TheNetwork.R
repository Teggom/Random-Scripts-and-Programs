if(!("png" %in% installed.packages())){install.packages("png");library("png")}else{library("png")}
if(!("neuralnet" %in% installed.packages())){install.packages("neuralnet");library("neuralnet")}else{library("neuralnet")}
if(!("dplyr" %in% installed.packages())){install.packages("dplyr");library("dplyr")}else{library("dplyr")}
setwd("G:/Table/")

Data <- read.csv(file = "22000.csv",stringsAsFactors = F)
Training <- t(Data[,4])
Test <- t(Data[,51:55])
Training <- data.frame(Training)
Test <- data.frame(Test)
NNIn <- paste(paste(paste("X", 1201:3900, sep = ""), collapse = " + " ), "~", paste(paste("X", 1:1200, sep = ""), collapse = " + "))

time <- Sys.time()
NN <- neuralnet(NNIn, Training, hidden = c(), linear.output = T)
Sys.time() - time
