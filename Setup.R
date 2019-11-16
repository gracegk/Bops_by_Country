# devtools::install_github('charlie86/spotifyr')
library(spotifyr)
library(tidyverse)
library(lubridate)
library(data.table)

# my personal Spotify user id: 122043448
# id/secret: for this project
id <- 'ee9f6edc68c145e582d736fa7ddf0b6c'
secret <- 'a0b0680390e14015862964b209e798cc'
Sys.setenv(SPOTIFY_CLIENT_ID = id)
Sys.setenv(SPOTIFY_CLIENT_SECRET = secret)
access_token <- get_spotify_access_token()


###### Building the data set
## Make function based on process above, applicable for every csv file 
# Read in csv file, clean header issues, extract track IDs from URLs
# Add track feature data (split bc get_track_audio_features() only lets you enter 100 IDs at a time)
read_spotify_csv <- function(data) {
  new_data <- read.csv(data)
  names(new_data) <- lapply(new_data[1, ], as.character)
  new_data <- new_data[-1,] 
  new_data$id <- substring(new_data$URL, 32)
  new_data_1 <- get_track_audio_features(ids = new_data$id[1:100])
  new_data_2 <- get_track_audio_features(ids = new_data$id[101:200])
  new_data_features <- rbind(new_data_1, new_data_2)
  new_data <- full_join(new_data, new_data_features, by = 'id')
  new_data$Streams <- as.numeric(as.character(new_data$Streams))
  return(new_data)
}

US_2017_jan <- read_spotify_csv("Raw_Data/regional-us-weekly-2016-12-30--2017-01-06.csv")
US_2017_jul <- read_spotify_csv("Raw_Data/regional-us-weekly-2017-06-30--2017-07-07.csv")
US_2018_jan <- read_spotify_csv("Raw_Data/regional-us-weekly-2017-12-29--2018-01-05.csv")
US_2018_jul <- read_spotify_csv("Raw_Data/regional-us-weekly-2018-06-29--2018-07-06.csv")
US_2019_jan <- read_spotify_csv("Raw_Data/regional-us-weekly-2018-12-28--2019-01-04.csv")

TW_2017_jan <- read_spotify_csv("Raw_Data/regional-tw-weekly-2016-12-30--2017-01-06.csv")
TW_2017_jul <- read_spotify_csv("Raw_Data/regional-tw-weekly-2017-06-30--2017-07-07.csv")
TW_2018_jan <- read_spotify_csv("Raw_Data/regional-tw-weekly-2017-12-29--2018-01-05.csv")
TW_2018_jul <- read_spotify_csv("Raw_Data/regional-tw-weekly-2018-06-29--2018-07-06.csv")
TW_2019_jan <- read_spotify_csv("Raw_Data/regional-tw-weekly-2018-12-28--2019-01-04.csv")


# how to get genre of artist... such a roundabout way
phonyppl <- get_artist_audio_features('phony ppl')
phonypplID <- unique(phonyppl$artist_id)
phonyppl_etc <- get_artist(phonypplID)

