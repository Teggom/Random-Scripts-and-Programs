source("~/SendEmail1.R")
setwd("~/REALM/")
if(!("rvest" %in% installed.packages())){install.packages("rvest");library("rvest")}else{library("rvest")}
if(!("lubridate" %in% installed.packages())){install.packages("lubridate");library("lubridate")}else{library("lubridate")}
Units <- list()
warn_time <- c(16, 22)
Units[[1]] <- c("<Player 1>", "<Email for player 1>@<Specific messaging extension>")
Units[[2]] <- c("<Player 2>", "<Email for player 2>@<Specific messaging extension>")

check <- list()
for(each in 1:length(Units)){
  check[[each]] <- c(FALSE, FALSE)  ## ADD CODE TO RESET TO FALSE 
}  # if false, this means no warning has been sent. 
root_url <- "https://www.realmeye.com/player/"

File <- as.vector(read.table(file = "SERVER STATUS.txt", sep = "\n")$V1)
while(File=="Run"){
for(player in 1:length(Units)){
  print(paste(Sys.time(), ": Checking Status...", sep = ""))
  url <- paste(root_url, Units[[player]][1], sep = "")
  session <- html_session(url)
  Table <- session %>%
    html_nodes(".summary td")
  TimeAgo <- as.character(Table[grepl("timeago", Table)])
  Last_Seen <- gsub("T", " ", gsub("^.*title=\\\"|Z\\\">.*$", "", TimeAgo))
  Time_Difference <- as.numeric(difftime(Sys.time(), as.POSIXct(Last_Seen, tz = "UTC"), units = "hours"))
  if(Time_Difference>warn_time[1] && !check[[player]][1]){
    Build_Email(Target = Units[[player]][2], Subject = "ROTMG Daily Loot Collection Reminder", Body = 
                  paste("Hello ", Units[[player]][1], ", This is a warning that you have not been seen on ROTMG for ", Time_Difference, 
                        " Hours. Please do not forget to log on and collect your daily login reward!", sep = ""))
    Send_Email()
    print(paste("Sent an email to", Units[[player]][1], "  :   warning number 1"))
    check[[player]][2] <- FALSE
  }
  if(Time_Difference>warn_time[2] && !check[[player]][2]){
    Build_Email(Target = Units[[player]][2], Subject = "ROTMG Daily Loot Collection", Body = 
                  paste("Hello again ", Units[[player]][1], ", This is your final warning to claim your daily log in rewards!", sep = ""))
    Send_Email()
    print(paste("Sent an email to", Units[[player]][1], "  :   warning number 2"))
    check[[player]][2] <- FALSE
  }
}
  Sys.sleep(time = 3600)
}

