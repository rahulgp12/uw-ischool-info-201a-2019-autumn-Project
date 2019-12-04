# Please install (PLEASE UNCOMMENT AND INSTALL)
# install.packages("maps")
# install.packages("mapproj")

# Please setwd to your own working directory!
# setwd()

# Used libraries, don't forget to install packages on local
library(ggplot2)
library(dplyr)
library("maps")

source("functions.R")


shinyServer(
  function(input, output, session) {
    
    # Scatter plot for first tab, happiness vs feature
    output$myPlot <- renderPlot({
      feature_type <- data_2017 %>% select(input$Feature)
      feature_type_data <- as.numeric(unlist(feature_type))
      
      linear_fit_2017 <- lm(data_2017$Happiness.Score ~ feature_type_data,
                        data = data_2017)
      linear_plot <- ggplotRegression(linear_fit_2017, input$Feature)
      linear_plot
    })
    
    output$myHeatmap <- renderPlot({
      year <- input$Year
      
      # Functions to call dataset, tidy it up, and generate heatmap
      mydata <- year_data(year)
      mydata <- tidy_data(mydata)
      heat_map(mydata)
      
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

