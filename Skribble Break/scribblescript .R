library("rvest")
library("rvest")

url <- "http://skribbl.io/"

sessions <- html_session(url)
form <- html_form(sessions)[[2]]
#textbox <- sessions %>% html_node("#inputName") %>% html_form()



url <- "http://skribbl.io/?0z8z0lWBV2IC1YLLPFRK"
s <- GET(url)
pars <- list(
  name = "Script_bot",
  lang = "English"
  )
POST(url)



testsession<- html_session("http://skribbl.io/?0z8z0lWBV2IC1YLLPFRK")
testform <- html_form(testsession)[[2]]
#names(testform$fields) <- "Hi"
#set_values(testform, 'Hi' = "myName") 
set_values(testform)
submit_form(session = testsession,form = testform)


driver <- rsDriver()
checkForServer()
startServer()
remDrv <- remoteDriver()
remDrv$open()

remDrv$navigate(url = "http://skribbl.io/?0z8z0lWBV2IC1YLLPFRK")

driver <- rsDriver()
remDr <- driver[["client"]]
remDr$navigate("http://skribbl.io/?0z8z0lWBV2IC1YLLPFRK")
webElem <- remDr$findElement("id", "inputName")
webElem$highlightElement()
#webElem$value <- list("script-bot")
#webElem$sendKeysToElement(list("Script-bot"))
webElem$sendKeysToElement(list("Script-bot", key = "enter"))


webElem <- remDr$findElement("id", "inputChat")
for(letter in letters){
  webElem$sendKeysToElement(list(letter, key = "enter"))
  #Sys.sleep(.6)
}



remDrv$navigate(url = "www.pinturillo2.com")

webElem <- remDr$findElement()



