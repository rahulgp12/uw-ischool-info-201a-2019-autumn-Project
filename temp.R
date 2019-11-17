setwd('~/Projects/uw-ischool-info-201a-2019-autumn-Project')

data_2017 <- read.csv('data/2017.csv', stringsAsFactors = FALSE)

install.packages('ggplot2')

ggplot(data_2017, aes(x = Family, y = Happiness.Score)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("Comparing Effect of Family on Happiness Score")


ggplot(data_2017, aes(x = Freedom, y = Happiness.Score)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("Comparing Effect of Freedom on Happiness Score")



