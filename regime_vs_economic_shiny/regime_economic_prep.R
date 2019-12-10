# loading libraries to prep for my shinyapp

library(shiny)
library(tidyverse)
library(fs)
library(gganimate)
library(readr)
library(caTools)
library(ggplot2)
library(readr)

# reading i my graphics as RDS files

mymap1 <- read_rds("regime_vs_economic_shiny/mymap1.rds")
mymap2 <- read_rds("regime_vs_economic_shiny/mymap2.rds")
mymap3 <- read_rds("regime_vs_economic_shiny/mymap3.rds")
mymap4 <- read_rds("regime_vs_economic_shiny/mymap4.rds")
mymap5 <- read_rds("regime_vs_economic_shiny/mymap5.rds")
mymap6 <- read_rds("regime_vs_economic_shiny/mymap6.rds")

# saving my non-animated ggplots as images! just tell it what kind of file you want it to be then the named object you're wanting to convert

ggsave("mymap3.png", plot = mymap3)
ggsave("mymap4.png", plot = mymap4)
ggsave("mymap5.png", plot = mymap5)
ggsave("mymap6.png", plot = mymap6)


data <- read_rds("regime_vs_economic_shiny/data.rds")
