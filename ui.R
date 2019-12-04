# Please install (PLEASE UNCOMMENT AND INSTALL)
# install.packages("maps")
# install.packages("mapproj")

# Please setwd to your own working directory!
# setwd()

# Used libraries, don't forget to install packages on each local
library("shiny")
library("shinythemes")
library("dplyr")

source("functions.R")


# Renamed column names
desired_columns <- data_2017 %>%
  select(CapitaGDP, Family, LifeExpectancy, Freedom, Generosity, Government)
  


# Shiny UI
shinyUI(navbarPage(title = "Global Happiness Report",
                   theme = shinytheme("darkly"),
                   
                   # First tab
                   tabPanel("Scatterplot 1",
                            shinyServer(
                              pageWithSidebar(
                                headerPanel("Influential Factors on Global Happiness"),
                                sidebarPanel(
                                  selectInput("Feature", "Please Select Feature to Compare",
                                              choices = colnames(desired_columns)),
                                  h4("Top 3 Most Important Factors to Happiness w/R-squared score:"),
                                  p("GDP per Capita: 0.658"),
                                  p("Life Expectancy: 0.609"),
                                  p("Family: 0.564"),
                                  h4("Least Important Factor in Happiness:"),
                                  p("Generosity: 0.017")
                                ),
                                mainPanel(
                                  plotOutput("myPlot"),
                                  h3("What We Learned"),
                                  p("By plotting happiness scores of the 155 countries 
                                    on the y-axis
                                    and plotting the 6 key attributes on the x-axis, we
                                    were able to use linear regression to determine the
                                    coefficient of determination (R-squared), the y-intercept,
                                    the slope, and the p-value."),
                                  p("With these statistics, we were able to learn many things
                                    about the global patterns of the 155 data points. What we
                                    wanted to focus on, is the value of the coefficient of
                                    determination, also known as R-squared. This determines
                                    the variance in the data, the higher the number, the
                                    closer the points are to the fitted line.
                                    In other words for our data, the larger the
                                    value, the more correlation there is between global happiness
                                    and that specific feature."),
                                  p("To add, the extremely low p-values indicate strong evidence
                                    of our data, meaning that it is statistically unlikely that
                                    our data is inaccurate due to factors such as luck."),
                                  p("What surprised us was how low of a correlation there is between
                                    happiness scores and generosity. A \"R-squared\" score of just
                                    0.017726 shows that there is barely any correlation, which
                                    is shocking. The highest two factors were GDP and Life Expectancy,
                                    which was predictable since those factors are related to
                                    a person's general quality of life.")
                                )
                              )
                            )
                   ),
                   
                   # Tab 2
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
                   
                   # Tab 3
                   tabPanel("Heatmap",
                            shinyServer(
                              pageWithSidebar(
                                headerPanel("Global Happiness Heatmap"),
                                sidebarPanel(
                                  selectInput("Year", "Please Select a Year",
                                              choices = c("2015", "2016", "2017")),
                                ),
                                mainPanel(
                                  plotOutput("myHeatmap")
                                )
                              )
                            )
                   ),
                   
                   # Tab 4
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
                   ),
                   tabPanel("Link to Wiki",
                            shinyServer(
                              fluidPage(
                                headerPanel("Link to Wiki"),
                                mainPanel("View our Techinal Report Here
                                          : https://github.com/rahulgp12/uw-ischool-info-201a-2019-autumn-Project")
                                #uiOutput("wikiLink")
                              )
                            )
                   )
))

