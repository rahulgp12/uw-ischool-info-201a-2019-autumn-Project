
library("shiny")



shinyServer(
  pageWithSidebar(
    headerPanel("Global Happiness Report"),
    
    # Ideally if the CSV file is stored as a dataframe, we want to take all the
    # column names and put it down here.
    sidebarPanel(
      selectInput("Feature", "Please Select Feature to Compare",
                  choices = c("Family", "Freedom")),
    ),
    
    mainPanel(
      plotOutput("myPlot")
    )
    
  )
)
