setwd('~/Projects/uw-ischool-info-201a-2019-autumn-Project')

data_2017 <- read.csv('data/2017.csv', stringsAsFactors = FALSE)

install.packages('ggplot2')

print(colnames(data_2017))
c()

ggplot(data_2017, aes(x = Family, y = Happiness.Score)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("Comparing Effect of Family on Happiness Score")


ggplot(data_2017, aes(x = Freedom, y = Happiness.Score)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("Comparing Effect of Freedom on Happiness Score")

# Creates an un-interactive heatmap of the world using happiness scores
world_shape <- map_data("world") %>%      # Creates data table holding all countries
  rename(Country = region) %>%
  left_join(data_2017, by = "Country")    # Adds Happiness score data to map 
ggplot(world_shape) +
  geom_polygon(
    mapping = aes(x = world_shape$long, y = world_shape$lat, 
                  group = world_shape$group, fill = world_shape$Happiness.Score),
    color = "white", # shows country outlines
    size = 0.1       # thin border
  ) +
  coord_map() +
  scale_fill_continuous(low = "#132B43", high = "Red") +
  labs(fill = "Happiness Score (0-5)")

