require(RSelenium)
require(rvest)
require(foreach)
require(doParallel)



# Tested with:

# OS Name:                   Microsoft Windows 10 Pro
# OS Version:                10.0.17134 N/A Build 17134

# Firefox 67.0.1 (x64)
# Available at: https://www.mozilla.org/ro/firefox/

# openjdk 12.0.1 2019-04-16
# OpenJDK Runtime Environment (build 12.0.1+12)
# OpenJDK 64-Bit Server VM (build 12.0.1+12, mixed mode, sharing)
# Available at: https://jdk.java.net/12/ (Windows/x64 Build 12)

# Geckodriver v. 0.24.0 Windows/x64
# Available at: https://github.com/mozilla/geckodriver/releases

# Selenium Standalone Server v. 3.141.59
# Available at: https://www.seleniumhq.org/download/


# First start a selenium server
# by running into a bash/cmd 
# java -Dwebdriver.gecko.driver=geckodriver.exe -jar selenium-server-standalone-3.141.59.jar

############################### Utils ####################################################################################
# wait until is page is fully loaded and webelement is visible
 
wait <- function(driver = NULL, type = NULL, value_char = NULL){
  elem <- NULL
  while(is.null(elem)){
    elem <- tryCatch({driver$findElement(using = type, value = value_char)},
                            error = function(e){NULL})
  }
  return(elem)
}

##########################################################################################################################

# Globals
url_enformation <- "https://www.e-nformation.ro/"


# Selenium object
enformation <- function(user = NULL, password = NULL){

# TODO tests  
    
enfSel <- remoteDriver(remoteServerAddr = "127.0.0.1",
                                 port = 4444L,
                                 browserName = "firefox")
# local vars
css_login <- "a.w-actionbox-button.g-btn.type_default.emember_fancy_login_link"
css_username <- "input#login_user_name"
css_password <- "input#login_pwd"
css_login_button <- "input#doLogin.emember_button"
css_profil <- "a[href='/profil-acces']"

# navigation
enfSel$open()
enfSel$navigate(url_enformation)

login <- enfSel$findElement(using = "css", value = css_login)
login$clickElement()

username <- wait(driver = enfSel, type = "css", value_char = css_username)
username$sendKeysToElement(sendKeys = list(user))

passwd <- enfSel$findElement(using = "css", value = css_password)
passwd$sendKeysToElement(sendKeys = list(password))

login_click <- enfSel$findElement(using = "css", value = css_login_button)
login_click$clickElement()

Sys.sleep(4)
#TODO bug  wait function does not find element
# force Sys.sleep
inst_profil <- wait(driver = enfSel, type = "css", value_char = css_profil)
inst_profil$clickElement()

enfSel$executeScript(script = "window.scrollTo(0, document.body.scrollHeight);")

# results
return(enfSel)
}


# Usage 
# enfSel <- enformation(user, password)
# user  - string -  The username under which the enformation account is registered
# password - string -The password for the enformation account

# Returns an object of class remoteDriver which contains all the credentials for accesing scientific databases provided
# by enformation platform



