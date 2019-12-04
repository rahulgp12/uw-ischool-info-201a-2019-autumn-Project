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
    
    #Scatterplot for second tab, happiness vs feature by region
    # output$regionalPlot <- renderPlot({
    #   feature_type <- data_2017 %>% select(input$Feature)
    #   feature_type_data <- as.numeric(unlist(feature_type))
    #   
    #   linear_fit_2017 <- lm(data_2017$Happiness.Score ~ feature_type_data,
    #                         data = data_2017)
    #   linear_plot <- ggplotRegression(linear_fit_2017, input$Feature)
    #   linear_plot
    #})
    
    
    
    
    
    
    output$myHeatmap <- renderPlot({
      year <- input$Year
      
      # Functions to call dataset, tidy it up, and generate heatmap
      mydata <- year_data(year)
      mydata <- tidy_data(mydata)
      heat_map(mydata)
    })
    
    output$heatmapText <- renderText({
      year <- input$Year
      year <- as.character(year)
      if(year == "2015") {
        paste("<h3> Top Five Happiest Countries: </h3> <br/> 
              1. Switzerland (7.587) <br/>
              2. Iceland (7.561) <br/>
              3. Denmark (7.527) <br/>
              4. Norway (7.522) <br/>
              5. Canada (7.427) <br/>
              <h3> Top Five Unhappiest Countries: </h3> <br/>
              1. Togo (2.839) <br/>
              2. Burundi (2.905) <br/>
              3. Syria (3.006) <br/>
              4. Benin (3.340) <br/>
              5. Rwanda (3.465)") 
      } else if(year == "2016") {
        paste("<h3> Top Five Happiest Countries: </h3> <br/>
              1. Denmark (7.526) <br/>
              2. Switzerland (7.509) <br/>
              3. Iceland (7.501) <br/>
              4. Norway (7.498) <br/>
              5. Finland (7.413) <br/>
              <h3> Top Five Unhappiest Countries </h3> <br/>
              1. Burundi (2.905) <br/>
              2. Syria (3.069) <br/>
              3. Togo (3.303) <br/>
              4. Afghanistan (3.360) <br/>
              5. Benin (3.484)")
      } else {
        paste("<h3> Top Five Happiest Countries: </h3> <br/>
              1. Norway (7.537) <br/>
              2. Denmark (7.522) <br/>
              3. Iceland (7.504) <br/>
              4. Switzerland (7.494) <br/>
              5. Finland (7.469) <br/>
              <h3> Top Five Unhappiest Countries </h3> <br/>
              1. Central African Republic (2.693) <br/>
              2. Burundi (2.905) <br/>
              3. Tanzania (3.349) <br/>
              4. Syria (3.462) <br/>
              5. Rwanda (3.471)")
      }
    })
    observe({
      x <- input$t4_year
      updateSelectInput(session, "t4_category",
                        choices = category_list(input$t4_year)
      )
    })
    output$map <- renderLeaflet({
      x <- input$t4_year
      y <- input$t4_category
      df <- top_ten(x, y)
      leaflet(data = df) %>%
        addProviderTiles("CartoDB.Positron") %>%
        setView(lng = 19.087508, lat = 12.127659, zoom = 1.3055) %>%
        addMarkers(
          lat = ~latitude,
          lng = ~longitude,
          popup = paste("Country:", df$Country, "<br>",
                        "Chosen Category:", y, "<br>",
                        "Rank:", df$Rank, "<br>",
                        "Happiness Rank:", df$Happiness.Rank, "<br>"
                        
          )
        )
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

