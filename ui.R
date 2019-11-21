
library("shiny")
library("shinythemes")
library("dplyr")

data_2017 <- read.csv('data/2017.csv', stringsAsFactors = FALSE)
desired_columns <- select(data_2017, Economy..GDP.per.Capita., Family, Health..Life.Expectancy.,
                          Freedom, Generosity, Trust..Government.Corruption.)

shinyUI(navbarPage(title = "Global Happiness Report",
                   theme = shinytheme("darkly"),
                   tabPanel("Scatterplot 1",
                            shinyServer(
                              pageWithSidebar(
                                headerPanel("Influential Factors on Global Happiness"),
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
                   tabPanel("Scatterplot 2",
                            shinyServer(
                              pageWithSidebar(
                                headerPanel("Regional Influence on Global Happiness"),
                                sidebarPanel("Will contain interactive options 
                                             based on country's region"
                                ),
                                mainPanel("Will show the scatterplot with interactive 
                                          x-axis and happiness scores on y-axis")
                              )
                            )
                   ),
                   tabPanel("Heatmap",
                            shinyServer(
                              pageWithSidebar(
                                headerPanel("Global Happiness Heatmap"),
                                sidebarPanel("Will contain a legend to interpret heatmap"),
                                mainPanel("Will contain a global heatmap showing happiness
                                          scores. Hovering on a country will bring up
                                          additional info about the country.")
                              )
                            )
                   ),
                   tabPanel("Dot-Distribution Map",
                            shinyServer(
                              pageWithSidebar(
                                headerPanel("Country Superlatives"),
                                sidebarPanel("Will allow user to select which superlative
                                             they want to test/observe"),
                                mainPanel("Will contain a world map that displays markers
                                          labeling the top ten (blank) countries where blank
                                          is selected by the user in the sidebar. Clicking
                                          on a dot will bring up additional info about the
                                          country.")
                              )
                            )
                   )
))
