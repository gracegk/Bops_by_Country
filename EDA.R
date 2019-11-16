source("Setup.R")
library(plotly)

# danceability, speechiness, acousticness, valence, tempo, duration_ms


ggplot(data = TW_2017_jan, mapping = aes(x = speechiness, y = log(Streams))) + 
  geom_point()

ggplot(data = US_2017_jan, mapping = aes(x = speechiness, y = log(Streams))) + 
  geom_point()

################################

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

all <- rbind(usa, taiwan)
all$country[1:1000] <- "USA"
all$country[1001:2000] <- "Taiwan"

plot_density_dance <- ggplot(all, aes(x=danceability, fill=country,
                                          text = paste(country)))+
  geom_density(alpha=0.7, color=NA)+
  labs(x="Danceability", y="Density") +
  guides(fill=guide_legend(title="Country"))+
  theme_minimal()+
  ggtitle("Distribution of Danceability Data")

ggplotly(plot_density_dance, tooltip=c("text"))

ggplot(all, mapping = aes(x = danceability, y = Streams, color = country)) + 
  geom_point()

################################

# proportion of streams?
US_2017_jan[1,4]/sum(US_2017_jan$Streams)
US_2017_jan$stream_pct <- US_2017_jan$Streams/sum(US_2017_jan$Streams) * 100
TW_2017_jan$stream_pct <- TW_2017_jan$Streams/sum(TW_2017_jan$Streams) * 100

jan2017 <- rbind(TW_2017_jan, US_2017_jan)
jan2017$country[1:200] <- "Taiwan"
jan2017$country[201:400] <- "USA"

# comparing USA, Taiwan's number of streams over track qualities
ggplot(data = jan2017, mapping = aes(x = speechiness, y = stream_pct, color = country)) + 
  geom_boxplot()

ggplot(data = jan2017, mapping = aes(x = danceability, y = stream_pct, color = country)) + 
  geom_point()

ggplot(data = jan2017, mapping = aes(x = danceability, y = stream_pct, color = country)) + 
  geom_boxplot()

ggplot(data = jan2017, mapping = aes(x = danceability, y = stream_pct, color = country)) + 
  geom_violin()

ggplot(data = jan2017, mapping = aes(x = valence, y = stream_pct, color = country)) + 
  geom_boxplot()

plot_density_dance <- ggplot(jan2017, aes(x=danceability, fill=country,
                            text = paste(country)))+
  geom_density(alpha=0.7, color=NA)+
  labs(x="Danceability", y="Density") +
  guides(fill=guide_legend(title="Playlist"))+
  theme_minimal()+
  ggtitle("Distribution of Danceability Data")

ggplotly(plot_density_dance, tooltip=c("text"))