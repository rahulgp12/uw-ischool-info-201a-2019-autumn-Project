# Hey Geo, I couldn't quite figure out how to get the CSV data to save and
# display on the Shiny App. But for right now this is a basic UI we can
# use. Since you have some experience, I could use some help here.
library(ggplot2)

# Feel free to change this when working
data_2017 <- read.csv('data/2017.csv', stringsAsFactors = FALSE)


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
)