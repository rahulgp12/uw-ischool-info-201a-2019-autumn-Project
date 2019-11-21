# Used libraries, don't forget to install packages on local
library(ggplot2)

# 2017 Global Happiness data frame we're working with
data_2017 <- read.csv('data/2017.csv', stringsAsFactors = FALSE)

# Renamed column names
data_2017 <- data_2017 %>%
  select(Economy..GDP.per.Capita., Family, Health..Life.Expectancy.,
         Freedom, Generosity, Trust..Government.Corruption., Happiness.Score) %>%
  rename(CapitaGDP = Economy..GDP.per.Capita., LifeExpectancy = Health..Life.Expectancy.,
         Government = Trust..Government.Corruption.)


shinyServer(
  function(input, output, session) {
    output$myPlot <- renderPlot({
      feature_type <- input$Feature
      
      # Interactive graph
      ggplot(data_2017, aes_string(x = feature_type, y = "Happiness.Score")) +
        geom_point() +
        geom_smooth(method = "lm", se = FALSE) +
        ggtitle(paste("Comparing Effect of", feature_type, "on Happiness Score"))
      
    })
  }

# this code is bugged but will be used in the future  
#  function(input, output, session) {
#    wikiURL <- a("Link to Wiki", href = 
#                "https://github.com/rahulgp12/uw-ischool-info-201a-2019-autumn-Project/wiki/Technical-Report")
#    output$wikiLink <- renderUI({
#      tagList("Read our Technical Report Here:", wikiURL)
#    })
#  }
)

