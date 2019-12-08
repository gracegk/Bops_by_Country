source("Setup.R")
library(knitr)
library(rstan)
library(arm)
library(rstanarm)
library(bayesplot)
library(loo)

length(unique(all[["Artist"]]))
length(unique(usa[["Artist"]]))
length(unique(US_2017_jan[["Artist"]]))
length(unique(taiwan[["Artist"]]))
# number of artists that appear in each collection of charts is much less than the number of songs.
# artists = groups?

fit_usa <- lmer(log(Streams) ~ speechiness + acousticness*danceability + (1|Artist), 
                data = usa)
summary(fit_usa)

fit_usa2 <- lmer(log(Streams) ~ speechiness + acousticness*danceability + 
                  (1+speechiness|Artist), 
                data = usa)
summary(fit_usa2)

fit_usa3 <- lmer(Streams~ speechiness + acousticness + danceability + (1|Artist), 
                 data = usa)
summary(fit_usa3)
display(fit_usa3)


fit_taiwan <- lmer(log(Streams) ~ speechiness + acousticness*danceability + (1|Artist), 
                   data = taiwan)
display(fit_taiwan)
plot(fit_taiwan)


