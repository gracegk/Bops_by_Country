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

