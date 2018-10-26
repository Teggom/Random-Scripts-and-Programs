Convert_To_Binary<-function(a){
  Working_Value <- a
  Power <- 0
  Binary_Number <- 0
  while(Working_Value!=0){
    Binary_Number <- Binary_Number+((Working_Value%%2)*10^Power)
    Working_Value <- as.integer(Working_Value/2)
    Power <- Power+1
  }
  Binary_Number
  #Largest Number is 4,294,967,295
}