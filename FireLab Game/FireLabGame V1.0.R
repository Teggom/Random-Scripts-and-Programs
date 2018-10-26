#loads packages
if(!("svDialogs" %in% installed.packages())){install.packages("svDialogs");library("svDialogs")}else{library("svDialogs")}

#Helper Functions
Print_Messages <- function(List){
  for(x in 1:length(List)){
    dlgMessage(List[x], "ok")
  }
}


#Basic gameplay Options/Variables
Name <- ""
Age <- ""
Hype <- 0
Lab_Hours_Left <- 6
Total_Lab_Hours_Left <- 72

R_Skill <- 0
Graph_Skill <- 0
Research_Skill <- 0
Research_Progress <- 0
Fame <- 0
Renown_with_peers <- 0
Renown_with_peer_mentors <- 0
Reflex_Check <- 0
Energy <- 10+Hype

#Lab Options
#Study R
#Study Graphical Functions
#Study Fun R Functions
#Look Over Research Papers
#Talk to Other Members
#Help Other Members
#Goof Off
#Appease Peer Mentor Gods with Food
Lab_Options <- c("Study R", "Research", "Talk to other lab members", "Goof off")

#dlgList(choices, preselect = NULL, multiple = FALSE, title = NULL, gui = .GUI)$res
#dlgInput(message = "Enter a value", default = "")$res
#dlgMessage(c(), "<type>")
#set up directory stuff
if(!("DDO" %in% dir())){dir.create("DDO");setwd("DDO");write("", file = "save.txt");choices <- c("New Game", "Quit")}else{setwd("DDO");choices <- c("New Game", "Load Game", "Quit")}

#menu creation
dlgMessage(c("Welcome to the FIRE Game", "Please expect bugs"), "ok")
Menu_Choice <- dlgList(choices, preselect = "New Game", title = "Main Menu")$res

#Menu Quit Option
if(Menu_Choice == "Quit"){
  dlgMessage(c("Have a nice day!"), title = "Quitting", "ok")
  print("FFF")
}

#Menu Load game Option




#Menu New Game Option
Name <- dlgInput(message = "Please enter your name!", default = "Loser")$res
Age <- dlgInput(message = "Please enter your age!", default = "18")$res
while(Hype < 1 || Hype > 5){
  Hype <- as.numeric(dlgInput(message = "From min 1 to max 5, How excited are you to be in the Fire Program!?")$res)
  if(is.na(Hype)){dlgMessage(c("Please enter a valid Hype level!"), "ok");Hype <- 0}else{if(Hype > 5 || Hype < 1){dlgMessage(c("Please enter a valid Hype Level!"), "ok"); Hype <- 0}}
}
Energy <- Energy + Hype
#Welcome Message
Welcome_Message <- c("Hello new Fire student!",
                     "You have been chosen for the Sustainability Analytics Substream",
                     "Your Research Educator is known as the Mysterious Ian B Page!",
                     "Remember to log your lab hours and stay focused!!!")


Print_Messages(Welcome_Message)
Days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
#Weekly Messages 
Week1_Message <- c("It is the first week of the semester",
                   "You have been tasked with studying up on R for the coming weeks")



Week <- 0

while(Week < 12){
  Week <- Week +1
  if(Week == 4){Lab_Options <- c(Lab_Options, "Work on Weekly Task")}
  Time_To_Complete_Weekly_Task <- sample(3:5, 1)
  v <- sample(1:2, 1)
  if(v <- 1){R_Task <- TRUE}else{R_Task <- FALSE}
  #Weekly Messages
  if(Week == 1){Print_Messages(Week1_Message)}
  if(Week == 1){dlgMessage(paste("72 Hours Remain"))}
  
  
  quit <- dlgMessage("Would you like to save and quit?", "yesno")$res
  
  if(quit == "yes"){quit()}
  if(Week >= 4){
    if(R_Task){
      dlgMessage(paste("Your weekly task involves R and will take ", Time_To_Complete_Weekly_Task, " hours to complete!", sep = ""), "ok")
    } else {
      dlgMessage(paste("Your weekly task involves research and will take ", Time_To_Complete_Weekly_Task, " hours to complete!", sep = ""), "ok")
    }
  }
  #Notifications
  if(Renown_with_peer_mentors < -14){
    dlgMessage(message = "The peer mentors are angry, maybe stop helping your fellow researchers for a while", "ok")
  }
  
  #Day Loop
  for(x in 1:length(Days)){
    
    if(Days[x] == "Thursday" || Days[x] == "Friday" && Renown_with_peer_mentors < -14){Renown_with_peer_mentors <- Renown_with_peer_mentors + 1}
    if(R_Skill > 20 && !("Research Graphing in R" %in% Lab_Options)){Lab_Options <- c(Lab_Options,"Research Graphing in R")} 
    if(R_Skill > 35 && !("Help Peers with R" %in% Lab_Options)){Lab_Options <- c(Lab_Options, "Help Peers with R")}
    if(Renown_with_peer_mentors < 0 && Renown_with_peer_mentors > -15){
      if(!("Appease Peer Mentor Gods with Food" %in% Lab_Options)){
        Lab_Options <- c(Lab_Options, "Appease Peer Mentor Gods with Food")}
      else{
        if("Appease Peer Mentor Gods with Food" %in% Lab_Options){
          Lab_Options <- Lab_Options[!Lab_Options=="Appease Peer Mentor Gods with Food"]
        }
      }
    }
    stat_view <- dlgMessage("Would you like to view your stats?", "yesno")$res
    if(stat_view == "yes"){
      Stats <- c()
      Stats <- c(Stats, paste("Name:",Name, sep = " "))
      Stats <- c(Stats, paste("Age:", Age, sep = " "))
      Stats <- c(Stats, paste("Research Progress:", Research_Progress, sep = " "))
      Stats <- c(Stats, paste("Goal Hours at end of week: ", (72-(6*Week)), sep = ""))
      Stats <- c(Stats, paste("Hours left in lab total: ", Lab_Hours_Left, sep = ""))
      Stats <- c(Stats, paste("Hours to complete weekly task:", Time_To_Complete_Weekly_Task, sep = " "))
      Stats <- c(Stats, paste("R Skill:", R_Skill, sep = " "))
      Stats <- c(Stats, paste("Graphing Skill:", Graph_Skill, sep = " "))
      Stats <- c(Stats, paste("Research Skill:", Research_Skill, sep = " "))
      Stats <- c(Stats, paste("Renown among Peers:", Renown_with_peers, sep = " "))
      Stats <- c(Stats, paste("Renown among Peer Mentors:", Renown_with_peer_mentors, sep = " "))
      Stats <- c(Stats, paste("Fame: ", Fame, sep = ""))
      Stats <- c(Stats, paste("Energy:", Energy, sep = " "))
      Stats <- c(Stats, paste("Reflex Check:", Reflex_Check, sep = " "))
      dlgList(Stats)
    }
    if(Energy <= 0){dlgMessage("You are too tired to go to lab", "ok"); break}else{
      dlgMessage(message = paste("Today is", Days[x], sep = " "), "ok")
      
      labtoday <- dlgMessage(message = "Would you like to go to lab today?", "yesno")$res
      if(labtoday == "yes"){
        choice <- dlgList(c(Lab_Options, "Leave"),title = "Lab Options")$res
        Hours <- 0
        while(is.na(Hours) || Hours<=0 || (Hours > Energy || Hours > 8) ){
          Hours <- as.numeric(dlgInput(message = paste("How long would you like to ", choice, " You have enough energy for ", Energy, " Hours. (Max = 8)", sep = ""),)$res)
        }
        dlgMessage(message = "The day passes...", "ok")
        Energy <- Energy - Hours
        Lab_Hours_Left <- Lab_Hours_Left - Hours
        
        if(choice == "Research Graphing in R"){
          if(Graph_Skill <= 10){
            Graph_Skill <- Graph_Skill + Hours
          } else {
            if(Graph_Skill > 10 && Graph_Skill <=20){
              Graph_Skill <-Graph_Skill +  Hours * .5
            } else {
              if(Graph_Skill > 20){
                Graph_Skill <- Graph_Skill + Hours * .2
              }
            }
          }
        }
        #Study Fun R Functions
        if(choice == "Work on Weekly Task"){
          if(R_Task){
            Time_To_Complete_Weekly_Task <- Time_To_Complete_Weekly_Task - (Hours*(R_Skill/20))
          } else {
            Time_To_Complete_Weekly_Task <- Time_To_Complete_Weekly_Task - (Hours*(Research_Skill/12))
          }
        }
        if(choice == "Study R"){
          R_Skill <- R_Skill + Hours
          if(R_Skill > 40){R_Skill <- R_Skill - (Hours * .5)}
        }
        if(choice == "Research"){
          Research_Skill <- Research_Skill + Hours
          Research_Progress <- Research_Progress + (Graph_Skill * Hours * .1) + (Research_Skill * .1) + (Hours * .4) + ((Renown_with_peer_mentors + Renown_with_peers) * .15) + ((R_Skill/30)*Hours)
        }
        if(choice == "Help Peers with R"){
          if(sample(1:50, 1) > R_Skill){
            dlgMessage("You couldnt figure out the problem, Now you look dumb", "ok")
            Renown_with_peer_mentors <- Renown_with_peer_mentors + 1
            Renown_with_peers <- Renown_with_peers - 1
            R_Skill <- R_Skill - 1
          } else {
            dlgMessage("You expertly solve the problems that arise", "ok")
            Fame <- Fame + Hours * .25
            Renown_with_peer_mentors <- Renown_with_peer_mentors - Hours
            Renown_with_peers <- Renown_with_peers + Hours
            if(sample(1:5, 1) == 1){ Renown_with_peers + 1}
          }
        }
        if(choice == "Talk to other lab members"){
          if(sample(1:15, 1) == 1){
            dlgMessage("Ian tells you to get back to work", "ok")
          } else {
            dlgMessage("While not productive, you had a good time")
            Fame <- Fame + (Hours * .1)
            Energy <- Energy + (Hours * .2)
            Renown_with_peer_mentors  <- Renown_with_peer_mentors + (Hours * .1)
            Renown_with_peers <- Renown_with_peers + (Hours * .4)
          }
        }
        if(choice == "Goof off") {
          #get caught
          if(sample(1:10) == 1){
            dlgMessage("Emperor Ian walks in as you sit on facebook...", "ok")
            if(sample(0:5, 1) <= Reflex_Check){
              dlgMessage("Your reflex check saved you!", "ok")
            } else {
              if(Lab_Hours_Left <= 0 || sample(1:6) == 6){
                dlgMessage("Ian Lets it slide", "ok")
              }else{
                dlgMessage("You got in trouble!", "ok")
                Lab_Hours_Left <- Lab_Hours_Left + Hours
                Renown_with_peer_mentors <- Renown_with_peer_mentors - 5
                Renown_with_peers <- Renown_with_peers - 5
                Reflex_Check <- Reflex_Check + 1
              }
            }
          }
          else {
            Energy <- Energy + (Hours * .5)
          }
        }
        if(choice == "Appease Peer Mentor Gods with Food"){
          Fame <- Fame + (Hours * .1)
          Renown_with_peer_mentors <- Renown_with_peer_mentors + Hours
        }
      }
    }
    
    
    
    
  }
  if(Energy < 1){Energy <- Energy + 5}else{Energy + 6.5}
  if(Energy > 10+Hype){Energy <- 10+Hype}
  if(Time_To_Complete_Weekly_Task<=0){
    dlgMessage("Congradulations on finishing your weekly task!")
    Fame <- Fame + 8
    
  }
}






























