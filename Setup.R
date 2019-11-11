# devtools::install_github('charlie86/spotifyr')
library(spotifyr)
library(tidyverse)
library(knitr)
library(lubridate)
library(dplyr)
library(data.table)

# my personal user id: 122043448
# id/secret: for this project
id <- 'ee9f6edc68c145e582d736fa7ddf0b6c'
secret <- 'a0b0680390e14015862964b209e798cc'
Sys.setenv(SPOTIFY_CLIENT_ID = id)
Sys.setenv(SPOTIFY_CLIENT_SECRET = secret)
access_token <- get_spotify_access_token()


my_playlists <- get_user_playlists("122043448")
my_playlists2 <- my_playlists %>%
  filter(name %in% c('United States Top 50'))
tracks <- get_playlist_tracks(my_playlists2$id)
features <- get_track_audio_features(tracks)
get_track_audio_features()


USA_2017_jan <- read.csv("~/Documents/MSSP Fall 2019/MA678/Bops_by_Country/Raw_Data/regional-us-weekly-2016-12-30--2017-01-06.csv")
names(USA_2017_jan) <- lapply(USA_2017_jan[1, ], as.character)
USA_2017_jan <- USA_2017_jan[-1,] 
USA_2017_jan$trackID <- substring(USA_2017_jan$URL, 32)

USA2017jan_1 <- get_track_audio_features(ids = USA_2017_jan$trackID[1:100])


