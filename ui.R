install.packages("shiny")
library("shiny")

shinyServer(
  pageWithSidebar(
    headerPanel("Global Happiness Report"),
    
    sidebarPanel("Side Bar temp"),
    
    mainPanel("Main Panel temp")
  )
)