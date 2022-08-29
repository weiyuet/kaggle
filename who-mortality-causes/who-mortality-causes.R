# Load libraries
library(tidyverse)
library(scales)

# Load data
who_mortality_causes <- read_csv("who-mortality-causes/who-mortality-causes.csv")

# Wrangle data
who_mortality_causes %>% filter(`Country Name` == "Singapore") %>% 
  filter(Year == 2020) %>% 
  ggplot(aes(x = Number)) +
  geom_bar() +
  theme_classic()
