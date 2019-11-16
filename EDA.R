library(spotifyr)
library(tidyverse)
library(lubridate)
library(data.table)

source("Setup.R")

# danceability, speechiness, acousticness, valence, tempo, duration_ms


ggplot(data = TW_2017_jan, mapping = aes(x = speechiness, y = log(Streams))) + 
  geom_point()

ggplot(data = US_2017_jan, mapping = aes(x = speechiness, y = log(Streams))) + 
  geom_point()


# proportion of streams?
US_2017_jan[1,4]/sum(US_2017_jan$Streams)
US_2017_jan$stream_pct <- US_2017_jan$Streams/sum(US_2017_jan$Streams) * 100
TW_2017_jan$stream_pct <- TW_2017_jan$Streams/sum(TW_2017_jan$Streams) * 100

jan2017 <- rbind(TW_2017_jan, US_2017_jan)
jan2017$country[1:200] <- "Taiwan"
jan2017$country[201:400] <- "USA"

# comparing USA, Taiwan's number of streams over track qualities
ggplot(data = jan2017, mapping = aes(x = speechiness, y = stream_pct, color = country)) + 
  geom_point()

ggplot(data = jan2017, mapping = aes(x = danceability, y = stream_pct, color = country)) + 
  geom_point()

ggplot(data = jan2017, mapping = aes(x = danceability, y = stream_pct, color = country)) + 
  geom_boxplot()

ggplot(data = jan2017, mapping = aes(x = valence, y = stream_pct, color = country)) + 
  geom_point()
