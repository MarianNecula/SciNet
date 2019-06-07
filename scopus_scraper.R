# Scopus

# In progress

scopus <- function(driver = NULL){
  css_scopus <- "//span[contains(text(), 'Scopus')]"
  css_link <- "a[href='http://am.e-nformation.ro/login?url=http://www.scopus.com']"
  css_affil <- "a[href='#affiliation']"
  scopus <- enfSel$findElement(using = "xpath", value = css_scopus)
  scopus$clickElement()
  scopus <- enfSel$findElement(using = "css", value = css_link)
  scopus$clickElement()
  affil <- wait(driver = enfSel, type = "css", value_char = css_affil)
  
  
}