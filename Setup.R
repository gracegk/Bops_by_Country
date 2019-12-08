# if spotifyr not installed, download the package from devtools: 
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


################################
###### Building the data set
## Make function based on process above, applicable for every chart's csv file 
read_spotify_csv <- function(data) {
  
  # Read in csv file
  new_data <- read.csv(data)
  
  # Clean header issues
  names(new_data) <- lapply(new_data[1, ], as.character)
  new_data <- new_data[-1,] 
  names(new_data)[2] <- "Track"
  
  # Extract track IDs from track URLs
  new_data$id <- substring(new_data$URL, 32)
  
  # Add track feature data
  # (split bc get_track_audio_features() only allows you to enter 100 IDs at a time)
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

## Combine the data sets for each time period by country
usa <- rbind(US_2017_jan, US_2017_jul, US_2018_jan, US_2018_jul, US_2019_jan)
usa$date[1:200] <- "2017-01"
usa$date[201:400] <- "2017-07"
usa$date[401:600] <- "2018-01"
usa$date[601:800] <- "2018-07"
usa$date[801:1000] <- "2019-01"

taiwan <- rbind(TW_2017_jan, TW_2017_jul, TW_2018_jan, TW_2018_jul, TW_2019_jan)
taiwan$date[1:200] <- "2017-01"
taiwan$date[201:400] <- "2017-07"
taiwan$date[401:600] <- "2018-01"
taiwan$date[601:800] <- "2018-07"
taiwan$date[801:1000] <- "2019-01"

## Combine the data sets for each country as one data set
all <- rbind(usa, taiwan)
all$country[1:1000] <- "USA"
all$country[1001:2000] <- "Taiwan"


################################
###### How to get an artist's genre. Produces several genres per artist.
# not sure if going to use yet. 
get_artist_genre <- function(artist) {
  artist_info <- get_artist_audio_features(artist)
  artistID <- unique(artist_info$artist_id)
  artist_info_list <- get_artist(artistID)
  return(artist_info_list$genres)
}

## Checking if get_artist_genre() function works
# get_artist_genre("Migos")
# get_artist_genre("EXO")
# get_artist_genre("Taylor Swift")

