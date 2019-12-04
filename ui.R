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
                   tabPanel("Global Happiness",
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
                   tabPanel("Happiness Over Time",
                            shinyServer(
                              pageWithSidebar(
                                headerPanel("Global Happiness Heatmap"),
                                sidebarPanel(
                                  selectInput("Year", "Please Select a Year",
                                              choices = c("2015", "2016", "2017")),
                                  htmlOutput("heatmapText"),
                                ),
                                mainPanel(
                                  plotOutput("myHeatmap"),
                                  h3("What We Learned"),
                                  p("By plotting the happiness scores of over 150 countries over the span
                                    of three years, 2015-2017, we were able to quickly visualize patterns
                                    that appeared in the data. Almost immediately, it became apparent that
                                    the happiest nations tended to reside in North America and Western Europe,
                                    while the unhappiest nations were typically found in Afica and Southeast
                                    Asia. This is consistent with the results from our influential factors 
                                    scatterplots, as countries in North America and Western Europe tend to 
                                    have much higher GDP per capita and Life Expectancies then their African
                                    and Southeast Asian counterparts."),
                                  p("While we were only working with a 3-year sample size, we were still
                                    surprised by the lack of change in happiness scores over time. Looking
                                    at the different heatmaps, it can be difficult to notice change on a year-
                                    to-year basis, which we attributed to the fact that societies rarely
                                    experience large shifts in collective happiness without a 'trigger' of some
                                    sort. One interesting fact we discovered is that after the controversial
                                    election of President Trump in 2016, the United States' happiness score fell",
                                    strong("below"), "7.00 for the first time in the three year span we measured."),
                                  p("A final takeaway when looking at happiness scores over time: pay attention to
                                    the Scandinavian countries. Denmark, Switzerland, Iceland, and Norway all
                                    ranked in the top 5 for overall happiness in every year we measured. Finland was
                                    also ranked in the top 5 in two of the three years we measured. In fact, the only
                                    non-Scandinavian country to crack the top 5 was Canada, in 2015. While our study
                                    does not allow us to make causation-based claims, all 5 countries are run similarly
                                    with regards to economic structure, and government welfare policies. The top 5
                                    unhappiest countries list was a little more volatile, as only Burundi and Syria
                                    were ranked all three years. Syria's place can most likely be attributed to the
                                    ongoing civil war currently afflicting the nation, while Burundi is widely
                                    considered unsafe due a rise in terrorism and violent crime.")
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
                   tabPanel("Learn More",
                            shinyServer(
                              fluidPage(
                                headerPanel("Learn More"),
                                mainPanel("View our Technical Report Here:", 
                                          a("Link to Wiki"),
                                          href = "https://github.com/rahulgp12/uw-ischool-info-201a-2019-autumn-Project")
                                #uiOutput("wikiLink")
                              )
                            )
                   )
))

