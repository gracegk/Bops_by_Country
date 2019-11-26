source("Setup.R")
library(knitr)
library(rstan)
library(arm)
library(rstanarm)

fit_usa <- lmer(log(Streams) ~ danceability + energy + speechiness + acousticness + valence + tempo + (1|date), 
                data = usa)
display(fit_usa)
plot(fit_usa)

ggplot(data = usa, mapping = aes(x = danceability, y = log(Streams))) + 
  geom_point() + 
  geom_line()