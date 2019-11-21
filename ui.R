
library("shiny")

data_2017 <- read.csv('data/2017.csv', stringsAsFactors = FALSE)

shinyServer(
  pageWithSidebar(
    headerPanel("Global Happiness Report"),
    
    # Ideally if the CSV file is stored as a dataframe, we want to take all the
    # column names and put it down here.
    sidebarPanel(
      selectInput("Feature", "Please Select Feature to Compare",
                  choices = colnames(data_2017)),
    ),
    
    mainPanel(
      plotOutput("myPlot")
    )
    
  )
)
