setwd("~")


Build_Email <- function(SenderU = "<Email Login>",
                        SenderP = "<Password>",
                        Target = "+<Phonenumber>@tmomail.net", 
                        Subject = "Default Subject", 
                        Body = "Message Here"){
  if(file.exists("BuiltEmail.ps1")){
    file.remove("BuiltEmail.ps1")
  }
  tryCatch({
    file.create("BuiltEmail.ps1")
  }, error = function(x){print("Failed to create Empty BuiltEmail.ps1")})
  
  ToSave <- c('$SMTPClient = New-Object Net.Mail.SmtpClient("smtp.gmail.com", 587)',
              '$SMTPClient.EnableSsl = $true',
              paste('$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("', SenderU, '", "', SenderP, '")', sep = ""),
              paste('$SMTPClient.Send("', SenderU, '", "',  Target, '", "', Subject, '", "', Body,'")', sep = ""))
  write("BuiltEmail.ps1", x = ToSave, sep = "\n")
  
}

Build_Email_Mass <- function(SenderU = "<Email Login>",
                        SenderP = "<Password>",
                        Target = "<Phonenumber>", 
                        Subject = "Default Subject", 
                        Body = "Message Here"){
  if(file.exists("BuiltEmail.ps1")){
    file.remove("BuiltEmail.ps1")
  }
  tryCatch({
    file.create("BuiltEmail.ps1")
  }, error = function(x){print("Failed to create Empty BuiltEmail.ps1")})
  TrueTarget <- paste(Target, Extensions, sep = "", collapse = ", ")
  ToSave <- c('$SMTPClient = New-Object Net.Mail.SmtpClient("smtp.gmail.com", 587)',
              '$SMTPClient.EnableSsl = $true',
              paste('$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("', SenderU, '", "', SenderP, '")', sep = ""),
              paste('$SMTPClient.Send("', SenderU, '", "',  TrueTarget, '", "', Subject, '", "', Body,'")', sep = ""))
  write("BuiltEmail.ps1", x = ToSave, sep = "\n")
}




Send_Email <- function(){
  system('powershell -command "Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force"')
  system('powershell -file "<Pathfile to .ps1 Script>"')
  system('powershell -command "Set-ExecutionPolicy restricted -Scope CurrentUser -Force"')
}

MyEmail <- "+<Phonenumber>@tmomail.net"
OtherEmails <- c()


Extensions <- c("@txt.att.net",
                "@mms.att.net",
                "@tmomail.net",
                "@vtext.com", 
                "@vzwpix.com",
                "@messaging.sprintpcs.com", 
                "@pm.sprint.com",
                "@vmobl.com",
                "@vmpix.com",
                "@mmst5.tracfone.com",
                "@mymetropcs.com",
                "@sms.myboostmobile.com",
                "@myboostmobile.com",
                "@sms.cricketwireless.net",
                "@mms.cricketwireless.net",
                "@text.republicwireless.com",
                "@msg.fi.google.com",
                "@email.uscc.net",
                "@mms.uscc.net",
                "@message.ting.com",
                "@mailmymobile.net",
                "@cspire1.com",
                "@vtext.com")