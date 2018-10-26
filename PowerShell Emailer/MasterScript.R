setwd("~")
source("SendEmail1.R")

for(each in 1:10){
  Build_Email(Target = "+<Phonenumber>@tmomail.net", Subject = paste("Message", each, "Of", 10), Body = "This is what you wanted.")
  Send_Email()
  print("Sent a message")
}

MyE <- "+<Phonenumber>@tmomail.net"