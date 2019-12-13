# loading libraries to prep for my shinyapp

library(shiny)
library(tidyverse)
library(fs)
library(gganimate)
library(readr)
library(caTools)
library(ggplot2)
library(readr)

# reading in my graphics as RDS files

mymap1 <- read_rds("regime_vs_economic_shiny/mymap1.rds")
mymap2 <- read_rds("regime_vs_economic_shiny/mymap2.rds")
mymap3 <- read_rds("regime_vs_economic_shiny/mymap3.rds")
mymap4 <- read_rds("regime_vs_economic_shiny/mymap4.rds")
mymap5 <- read_rds("regime_vs_economic_shiny/mymap5.rds")
mymap6 <- read_rds("regime_vs_economic_shiny/mymap6.rds")

# I wanted to make a separate file for my RDS and image files at first but unfortunately this broke my
# shiny app. Everything has to be in the same folder, even if it looks messy (which bothers me but hopefully this 
# requirement is changed in the future)

# saving my non-animated ggplots as images! just tell it what kind of file you want it to be then the named object you're wanting to convert
# it can even convert things to PDFs as well as other files which is neat
ggsave("mymap3.png", plot = mymap3)
ggsave("mymap4.png", plot = mymap4)
ggsave("mymap5.png", plot = mymap5)
ggsave("mymap6.png", plot = mymap6)

# reading my data into the prep.R file. I read it into the app.R file as well just to prevent things from
# potentially breaking if run remotely (not on my computer where files are easily found)
# I've found RDS files very useful in making code independent of their home directories.

data <- read_rds("regime_vs_economic_shiny/data.rds")
