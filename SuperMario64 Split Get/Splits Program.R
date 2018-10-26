####
####
####  Code by Teggom 
####
####
##
## There are two functions, get_data() -> goes to splits.io and pulls pages (MIGHT NEED TO CHANGE VARIABLE <last_page> BELOW if more pages are added), then spits out two datasets for global averages
## Second function is get_averages_for_time(LowerBound, UpperBound) <- Dependent on file from get_data(), Bounds are in minutes
##
## Make sure to run get_data() if you have never run it before to get the file you need for the second function to work!!!
##

last_page1 <- 10
last_page2 <- 6
#####CHANGE THIS IF MORE PAGES ARE ADDED

get_data <- function(){

  #make sure time is > 1:30:00
  #always take last split
  #make 121 colums
    #populate based on (####)
  
  #throw last row as averages
  #base_url <- "https://splits.io/games/sm64/categories/755?page="

  if(!("rvest" %in% installed.packages())){install.packages("rvest");library("rvest")}else{library("rvest")}
  
  #setup
  url_ends <- c()
  times <- c()
  #visits all the pages
  for(x in 1:last_page1){
    #visits the page x
    session <- html_session(paste("https://splits.io/games/sm64/categories/755?page=", x, sep = ""))
    
    #pulls all links for runs
    links <- session %>% html_nodes(".run-link") %>% html_attrs()
    t <- session %>% html_nodes(".time") %>% html_text()
    times <- c(times, t)
    #add it to a pre-existing vector
    for(y in 1:length(links)){
      f <- links[[y]]
      url_ends <- c(url_ends, as.character(f[2]))
    }
    print(paste("done page (2):", x, sep = " "))
  }
  for(x in 1:last_page2){
    session <- html_session(paste("https://splits.io/games/sm64/categories/4343?page=", x, sep = ""))
    links <- session %>% html_nodes(".run-link") %>% html_attrs()
    t <- session %>% html_nodes(".time") %>% html_text()
    times <- c(times, t)
    #add it to a pre-existing vector
    for(y in 1:length(links)){
      f <- links[[y]]
      url_ends <- c(url_ends, as.character(f[2]))
    }
    print(paste("done page (2) :", x, sep = " ")) 
  }
  #base setup
  stars <- as.character(1:120)
  
  a <- NA
  
  #makes basic dataframe
  df <- data.frame(a)
  if(!("dplyr" %in% installed.packages())){install.packages("dplyr");library("dplyr")}else{library("dplyr")}
  for(x in 1:120)
  {
    df <- dplyr::bind_cols(df, data.frame(a))
  }
  colnames(df) <- c(stars, "Done")
  for(x in 1:ncol(df)){
    df[,x] <- as.numeric(df[,x])
  }
  
  #stores an extra version
  base <- df
  df <- df[0,]
  #base url for data 
  score_url_base <- "https://splits.io"
  
  #magic happens here
  for(x in 1:length(url_ends)){
    working_frame <- base
    score_session <- html_session(paste(score_url_base, url_ends[x], sep = ""))
    names <- as.numeric(gsub("^.*\\(|\\).*$", "", score_session %>% html_nodes("td.align-left") %>% html_text()))
    split_times <- score_session %>% html_nodes(".align-right.time") %>% html_text()
    final_time_for_run <- as.numeric(times[x])
    split_times <- split_times[!is.na(names)]
    names <- names[!is.na(names)]
    #apparently the website stores times in seconds, and auto converts them upon request
    #hours <- as.numeric(gsub("\\:.*$", "", final_time_for_run))
    #m1 <- gsub("^[^:]:", "", final_time_for_run)
    #minutes <- as.numeric(gsub(":.*$", "", m1))
    #minutes <- minutes + (hours * 60)
    if( final_time_for_run/60 <= 90 || length(names) == 0){}else{
      working_frame$Done <- as.numeric(times[x])
      for(star_count in 1:length(names)){
        curr_star <- as.numeric(names[star_count])
        working_frame[1,curr_star] <- as.numeric(split_times[star_count])
      }
      df <- dplyr::bind_rows(df, working_frame)
    }
    print(paste("done ", x, " of ", length(url_ends), sep = ""))
  }
  
  
  #this makes average row
  average_row <- base
  for(x in 1:ncol(df)){
    average_row[1,x] <- mean(df[,x], na.rm = TRUE)
  }
  df <- dplyr::bind_rows(df, average_row)
  
  write.csv(df, file = "seconds_table_splits.csv",row.names = FALSE)
  df1 <- df
  
  for(x in 1:ncol(df)){
    df[,x] <- as.character(df[,x])
    for(row in 1:nrow(df)){
      if(!is.na(df[row,x]) && df[row,x]!="NaN"){
        seconds <- trunc(as.numeric(df[row,x]))
        sec <- as.character(seconds %% 60)
        minutes <- as.character(trunc(((seconds/60)%%60)))
        hours <- as.character(trunc(((seconds/60)/60)))
        if(as.numeric(sec) < 10){sec <- paste("0", sec, sep = "")}
        if(as.numeric(minutes) < 10){minutes <- paste("0", minutes, sep = "")}
        if(as.numeric(hours) < 10){hours <- paste("0", hours, sep = "")}
        df[row,x] <- paste(hours, minutes, sec, sep = ":")
      }
    }
    
    if(x == 121){print("done")}else{print(paste("Table fixed for ", x, " stars", sep = ""))}
  }
  
  write.csv(df, file = "formatted_table_splits.csv", row.names = FALSE)
}
  
get_averages_for_time <- function(lower_min, upper_min, Drop_Blank_Twenty = TRUE){
  g <- ""
  if(Drop_Blank_Twenty){g <- " Standard Run"}
  
  if(!("dplyr" %in% installed.packages())){install.packages("dplyr");library("dplyr")}else{library("dplyr")}
  sec_df <- read.csv("seconds_table_splits.csv", header = TRUE)
  colnames(sec_df) <- c(as.character(1:120), "done")
  super_df <- sec_df[0,]
  for(x in 1:(nrow(sec_df)-1)){
    final <- sec_df$done[x]
    minute_row <- trunc(final/60)
    if(minute_row >= lower_min && minute_row <= upper_min){super_df <- dplyr::bind_rows(super_df, sec_df[x,])}
  }
  
  if(Drop_Blank_Twenty){
    y <- super_df[0,]
    for(x in 1:nrow(super_df)){
      if(!is.na(super_df[x,20])){
        y <- dplyr::bind_rows(y, super_df[x,])
      }
    }
    super_df <- y
  }
  
  average_row <- sec_df[1,]
  
  for(x in 1:ncol(super_df)){
    average_row[1,x] <- NA
    average_row[1,x] <- mean(super_df[,x], na.rm = TRUE)
  }
  super_df <- dplyr::bind_rows(super_df, average_row)
  
  df <- super_df
  for(x in 1:ncol(df)){
    df[,x] <- as.character(df[,x])
    for(row in 1:nrow(df)){
      if(!is.na(df[row,x]) && df[row,x]!="NaN"){
        seconds <- trunc(as.numeric(df[row,x]))
        sec <- as.character(seconds %% 60)
        minutes <- as.character(trunc(((seconds/60)%%60)))
        hours <- as.character(trunc(((seconds/60)/60)))
        if(as.numeric(sec) < 10){sec <- paste("0", sec, sep = "")}
        if(as.numeric(minutes) < 10){minutes <- paste("0", minutes, sep = "")}
        if(as.numeric(hours) < 10){hours <- paste("0", hours, sep = "")}
        df[row,x] <- paste(hours, minutes, sec, sep = ":")
      }
    }
    
    if(x == 121){print("done")}else{print(paste("Table fixed for ", x, " stars", sep = ""))}
  }
  
  hours_lower <- as.character(trunc(lower_min/60))
  min_lower <- as.character(trunc(lower_min%%60))
  hours_upper <- as.character(trunc(upper_min/60))
  min_upper <- as.character(trunc(upper_min%%60))
  if(hours_lower < 10){hours_lower <- paste("0", hours_lower, sep = "")}
  if(hours_upper < 10){hours_upper <- paste("0", hours_upper, sep = "")}
  if(min_lower < 10){min_lower <- paste("0", min_lower, sep = "")}
  if(min_upper < 10){min_upper <- paste("0", min_upper, sep = "")}
  
  write.csv(x = df,       file = paste("Formatted Data for runs from ", hours_lower, "-", min_lower, " to ", hours_upper, "-", min_upper, g, ".csv", sep = ""))
  write.csv(x = super_df, file = paste("Seconds Data for runs from ", hours_lower, "-", min_lower, " to ", hours_upper, "-", min_upper, g, ".csv", sep = ""))
}










