# Just some messing around with what I had in the other file. 

source("Pointers.R")

Pointers <- new.env()
assign(x = "asdfash2", value = 10, envir = Pointers)


Brac_Time <- c()
for(each in 1:1000){
  Start = Sys.time()
  for(x in 1:(each *1000)){
    a <- Pointers[["asdfash2"]]
  }
  Brac_Time <- c(Brac_Time, Sys.time()-Start)
  print(each)
}  

Doll_Time <- c()
for(each in 1:1000){
  Start = Sys.time()
  for(x in 1:(each * 1000)){
    a <- Pointers$asdfash2
  }
  Doll_Time <- c(Doll_Time, Sys.time()-Start)
  print(each)
}

regular_get_time <- c()
for(each in 1:1000){
  Start = Sys.time()
  for(x in 1:(each*1000)){
    a <- a
  }
  regular_get_time <- c(regular_get_time, Sys.time()-Start)
  print(each)
}

a <- c()
b <- c()
c <- c()
for(each in 3:998){
  b <- c(b, sum(Brac_Time[(each-2):(each+2)]/5))
  c <- c(c, sum(Doll_Time[(each-2):(each+2)]/5))
  a <- c(a, sum(regular_get_time[(each-2):(each+2)]/5))
}

plot.new()
plot(x = 1:996, y = b, type = 'l', col = rainbow(10)[5], xlab = "Number of Operations (Thousands)", ylab = "Run Time (Seconds)", main = "Runtime comparison of 3 different environment accessor methods")
lines(x = 1:996, y = c, type = 'l', col = rainbow(10)[9])
lines(x = 1:996, y = a, type = 'l', col = rainbow(10)[1])
legend("topleft", legend = c("Pointers[['asdfash2']]", "Pointers$asdfash2", "LOCAL  : a <- a"), col = c(rainbow(10)[5], rainbow(10)[9], rainbow(10)[1]), lty = 1 )