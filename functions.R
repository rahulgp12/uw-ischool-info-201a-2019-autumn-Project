library(ggplot2)
library(dplyr)
library(plotly)
library(maps)
library(leaflet)


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

# Linear Regression plot for happiness by region
# countries <- map_data("world")
# datacountries <- data_2017_4.Country
# names(datacountries) <- tolower(names(datacountries))
# datacountries$region <- tolower(rownames(data_2017_4.Country))
# choro <- merge(countries, datacountries, sort = FALSE, by = "region")
# choro <- choro[order(choro$order),]

# ggplotTab <- function(fit, xlabel) {
#   ggplot(data_2017, aes(x = choro, y = data_2017.Happiness.Score) + 
#     geom_point() +
#     stat_smooth(method = "lm", col = "red") +
#     labs(x = xlabel, y = "Happiness Score"))
#}
#ggplot(data_2017, aes(x = xlabel, y = "Happiness Score")) +
#  geom_point()

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

# Tab 4 functions to produce a interactable map
data_2017_4 <- read.csv('data/2017.csv', stringsAsFactors = FALSE)
data_2016_4 <- read.csv('data/2016.csv', stringsAsFactors = FALSE)
data_2015_4 <- read.csv('data/2015.csv', stringsAsFactors = FALSE)
countries_geo <- read.csv('data/countries.csv', stringsAsFactors = FALSE)

year_list <- c("2017", "2016", "2015")

count_2017 <- data_2017_4[1]
count_2017 <- unlist(count_2017[1], use.names = FALSE)
count_2016 <- data_2016_4[1]
count_2016 <- unlist(count_2016[1], use.names = FALSE)
count_2015 <- data_2015_4[1]
count_2015 <- unlist(count_2015[1], use.names = FALSE)




get_geo_lat <- function(country1){
  df <- countries_geo
  df_1 <- df %>%
    filter(name == country1)
  df_1 <- df_1[[1, 2]]
  return((df_1))
}
get_geo_lon <- function(country1){
  df <- countries_geo
  df_1 <- df %>%
    filter(name == country1)
  df_1 <- df_1[[1, 3]]
  return((df_1))
}
test_lat <- get_geo_lat("Somaliland Region")
test_lon <- get_geo_lon("United States")

lat_list <- function(df){
  x <- df
  x <- lapply(x, get_geo_lat)
  y <- unlist(x, use.names = FALSE)
  
  return(y)
}
lon_list <- function(df){
  x <- df
  x <- lapply(x, get_geo_lon)
  y <- unlist(x, use.names = FALSE)
  return(y)
}
test_lon_list <- lon_list(count_2017)
test_lat_list <- lat_list(count_2017)
test_lon_list_2016 <- lon_list(count_2016)
test_lat_list_2016 <- lat_list(count_2016)
test_lon_list_2015 <- lon_list(count_2015)
test_lat_list_2015 <- lat_list(count_2015)
new_2017 <- data_2017_4
new_2016 <- data_2016_4
new_2015 <- data_2015_4
add_geo_list <- function(df){
  df$latitude = test_lat_list
  df$longitude = test_lon_list
  return(df)
}


add_geo_list_2016 <- function(df){
  df$latitude = test_lat_list_2016
  df$longitude = test_lon_list_2016
  return(df)
}
add_geo_list_2015 <- function(df){
  df$latitude = test_lat_list_2015
  df$longitude = test_lon_list_2015
  return(df)
}
new_2017 <- add_geo_list(new_2017)
new_2016 <- add_geo_list_2016(new_2016)
new_2015 <- add_geo_list_2015(new_2015)


top_ten <- function(year, category){
  if(year == "2017"){
    x <- new_2017
  }
  if (year == "2016"){
    x <- new_2016
  }
  if (year == "2015"){
    x <- new_2015
  }
  if (category == "Happiness.Rank") {
    x <- x[order(x[, category], decreasing = FALSE), ]
  }
  else {
    x <- x[order(x[, category], decreasing = TRUE), ]
  }
  x <- x[1:10, ]
  x <- mutate(x, Rank = c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10"))
  return(x)
}
category_list <- function(year){
  if(year == "2017"){
    x <- colnames(data_2017_4)
    x <- x[2:12]
  }
  if (year == "2016"){
    x <- colnames(data_2016_4)
    x <- x[3:13]
  }
  if (year == "2015"){
    x <- colnames(data_2015_4)
    x <- x[3:12]
  }
  return(x)
}



