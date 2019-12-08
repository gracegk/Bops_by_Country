source("Setup.R")
library(plotly)
library(ggplot2)

# variables to consider: danceability, speechiness, acousticness, valence, tempo, duration_ms
# irrelevant variables: URL, type, uri, track_href, analysis_url

################################

## how data from different countries look like 
# distribution of speechiness

plot_density_speech <- ggplot(all, aes(x=speechiness, fill=country,
                                      text = paste(country)))+
  geom_density(alpha=0.7, color=NA)+
  labs(x="Speechiness", y="Density") +
  guides(fill=guide_legend(title="Country"))+
  theme_minimal()+
  ggtitle("Distribution of Speechiness Data")

ggplotly(plot_density_speech, tooltip=c("text"))

# distribution of acousticness

plot_density_acoustic <- ggplot(all, aes(x=acousticness, fill=country,
                                    text = paste(country)))+
  geom_density(alpha=0.7, color=NA)+
  labs(x="Acousticness", y="Density") +
  guides(fill=guide_legend(title="Country"))+
  theme_minimal()+
  ggtitle("Distribution of Acousticness Data")

ggplotly(plot_density_acoustic, tooltip=c("text"))

# distribution of danceability

plot_density_dance <- ggplot(all, aes(x=danceability, fill=country,
                                      text = paste(country)))+
  geom_density(alpha=0.7, color=NA)+
  labs(x="Danceability", y="Density") +
  guides(fill=guide_legend(title="Country"))+
  theme_minimal()+
  ggtitle("Distribution of Danceability Data")

ggplotly(plot_density_dance, tooltip=c("text"))

# distribution of energy

plot_density_energy <- ggplot(all, aes(x=energy, fill=country,
                                      text = paste(country)))+
  geom_density(alpha=0.7, color=NA)+
  labs(x="Energy", y="Density") +
  guides(fill=guide_legend(title="Country"))+
  theme_minimal()+
  ggtitle("Distribution of Energy Data")

ggplotly(plot_density_energy, tooltip=c("text"))

# distribution of valence -- not rly insightful

plot_density_val <- ggplot(all, aes(x=valence, fill=country,
                                    text = paste(country)))+
  geom_density(alpha=0.7, color=NA)+
  labs(x="Valence", y="Density") +
  guides(fill=guide_legend(title="Country"))+
  theme_minimal()+
  ggtitle("Distribution of Valence Data")

ggplotly(plot_density_val, tooltip=c("text"))

# distribution of tempo -- not that different. what's with the two peaks?

plot_density_tempo <- ggplot(all, aes(x=tempo, fill=country,
                                    text = paste(country)))+
  geom_density(alpha=0.7, color=NA)+
  labs(x="Tempo", y="Density") +
  guides(fill=guide_legend(title="Country"))+
  theme_minimal()+
  ggtitle("Distribution of Tempo Data")

ggplotly(plot_density_tempo, tooltip=c("text"))

# distribution of duration -- not rly insightful

plot_density_duration <- ggplot(all, aes(x=duration_ms, fill=country,
                                    text = paste(country)))+
  geom_density(alpha=0.7, color=NA)+
  labs(x="Duration", y="Density") +
  guides(fill=guide_legend(title="Country"))+
  theme_minimal()+
  ggtitle("Distribution of Duration Data")

ggplotly(plot_density_duration, tooltip=c("text"))

# distribution of liveness -- not rly insightful

plot_density_live <- ggplot(all, aes(x=liveness, fill=country,
                                    text = paste(country)))+
  geom_density(alpha=0.7, color=NA)+
  labs(x="Liveness", y="Density") +
  guides(fill=guide_legend(title="Country"))+
  theme_minimal()+
  ggtitle("Distribution of Liveness Data")

ggplotly(plot_density_live, tooltip=c("text"))

################################

# isolate the numeric variables
usa_test <- usa[,c(4, 7, 8, 10, 12, 13, 15, 16, 22)]
View(cor(usa_test))

## relationships between stream count or rank and song characteristics
# speechiness

ggplot(usa, aes(x=speechiness, y=log(Streams))) + 
  geom_point(aes(col=date)) + 
  ggtitle("Speechiness vs. Streams (USA)")

plot_ly(data=usa, x = ~speechiness, y = ~Streams, 
        type = "scatter", color = ~date, showlegend = T)

plot_ly(data=taiwan, x = ~speechiness, y = ~Streams, 
        type = "scatter", color = ~date, showlegend = T)

# acousticness

plot_ly(data=usa, x = ~acousticness, y = ~Streams, 
        type = "scatter", color = ~date, showlegend = T)


# danceability

plot_ly(data=usa, x = ~danceability, y = ~Streams, 
        type = "scatter", color = ~date, showlegend = T)


# artist as group?

################################

ggplot(data = all, mapping = aes(x = danceability, y = log(Streams), color=country)) + 
  geom_point() 

# compare stream percentage?

log(all$Streams)

get_stream_pct <- function(data) {
  stream_pct <- data$Streams[1:200]/sum(data$Streams) * 100
  return(stream_pct)
}