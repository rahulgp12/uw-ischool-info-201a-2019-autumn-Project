
library("shiny")
library("dplyr")

data_2017 <- read.csv('data/2017.csv', stringsAsFactors = FALSE)
desired_columns <- select(data_2017, Economy..GDP.per.Capita., Family, Health..Life.Expectancy.,
<<<<<<< HEAD
                          Freedom, Generosity, Trust..Government.Corruption.)

shinyUI(navbarPage(title = "Global Happiness Report",
                   tabPanel("Scatterplot 1",
                            shinyServer(
                              pageWithSidebar(
                                headerPanel("Global Happiness Report"),
                                sidebarPanel(
                                  selectInput("Feature", "Please Select Feature to Compare",
                                              choices = colnames(desired_columns)),
                                ),
                                
                                mainPanel(
                                  plotOutput("myPlot")
                                )
                                
                              )
                            )
                   ),
                   tabPanel("Scatterplot 2"),
                   tabPanel("Heatmap"),
                   tabPanel("Table")
))
=======
         Freedom, Generosity, Trust..Government.Corruption.)

shinyServer(
  pageWithSidebar(
    headerPanel("Global Happiness Report"),
    
    # Ideally if the CSV file is stored as a dataframe, we want to take all the
    # column names and put it down here.
    sidebarPanel(
      selectInput("Feature", "Please Select Feature to Compare",
                  choices = colnames(desired_columns)),
    ),
    
    mainPanel(
      plotOutput("myPlot")
    )
    
  )
)
>>>>>>> cd558e314b76a96d594e4d6d7755d46bfbd8ab3d
