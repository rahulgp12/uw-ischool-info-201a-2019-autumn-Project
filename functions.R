library(ggplot2)
library(dplyr)
library(plotly)
library(maps)


# 2017 Global Happiness data frame we're working with
data_2017 <- read.csv('data/2017.csv', stringsAsFactors = FALSE)

# Renamed column names
data_2017 <- data_2017 %>%
  select(Economy..GDP.per.Capita., Family, Health..Life.Expectancy.,
         Freedom, Generosity, Trust..Government.Corruption., Happiness.Score) %>%
  rename(CapitaGDP = Economy..GDP.per.Capita., LifeExpectancy = Health..Life.Expectancy.,
         Government = Trust..Government.Corruption.)


# Linear regression plot with stats.
ggplotRegression <- function(fit, xlabel) {
  ggplot(fit$model, aes_string(x = names(fit$model)[2], y = names(fit$model)[1])) + 
    geom_point() +
    stat_smooth(method = "lm", col = "red") +
    labs(title = paste("Adj R2 = ",signif(summary(fit)$adj.r.squared, 5),
                       " Intercept =",signif(fit$coef[[1]],5 ),
                       " Slope =",signif(fit$coef[[2]], 5),
                       " P =",signif(summary(fit)$coef[2,4], 5)),
         x = xlabel, y = "Happiness Score")
  
}


# Writing a function to call the desired data set based on selected year 
year_data <- function(year) {
  myyear <- paste0("data/", year, ".csv", sep = "")
  read.csv(myyear, stringsAsFactors = FALSE)
}
mydata <- year_data("2015")
mydata2 <- year_data("2016")
mydata3 <- year_data("2017")

# Writing a function to fix naming differences between happiness scores file and map
tidy_data <- function(data) {
  data <- data %>% 
    mutate(Country = ifelse(Country == 'United States', 'USA', Country))
  
  data <- data %>%
    mutate(Country = ifelse(Country == 'United Kingdom', 'UK', Country))
  
  data <- data %>%
    mutate(Country = ifelse(Country == 'Congo (Brazzaville)', 'Republic of Congo', Country))
  
  data <- data %>%
    mutate(Country = ifelse(Country == 'Congo (Kinshasa)', 'Democratic Republic of the Congo',
                            Country))
  
  data <- data %>%
    mutate(Country = ifelse(Country == 'Somaliland region', 'Somalia', Country))
  
  data <- data %>%
    mutate(Country = ifelse(Country == 'Somaliland Region', 'Somalia', Country))
}


# Writes a function that produces a heatmap based on an inputed year
# Creates an un-interactive heatmap of the world using happiness scores
heat_map <- function(mydata) {
  world_shape <- map_data("world") %>%      # Creates data table holding all countries
    rename(Country = region) %>%
    left_join(mydata, by = "Country")    # Adds Happiness score data to map 
  ggplot(world_shape) +
    geom_polygon(
      mapping = aes(x = world_shape$long, y = world_shape$lat, 
                    group = world_shape$group, fill = world_shape$Happiness.Score),
      color = "white", # shows country outlines
      size = 0.1       # thin border
    ) +
    coord_map() +
    scale_fill_continuous(low = "#132B43", high = "Red") +
    labs(fill = "Happiness Score (0-10)")  + coord_map(xlim=c(-180,180)) +
    xlab("Longitude") +
    ylab("Latitude")
}