# Load libraries
library(tidyverse)
library(scales)
library(patchwork)

# Load data
police_stops <- read_csv("minneapolis-police-stops-and-violence/data/police_stop_data.csv")
police_use_of_force <- read_csv("minneapolis-police-stops-and-violence/data/police_use_of_force.csv")

# Preliminary EDA
p1 = police_use_of_force %>% 
  ggplot(aes(x = ForceType)) +
  geom_bar() +
  geom_text(aes(label = ..count..), stat = "count", vjust = -0.3) +
  scale_y_continuous(limits = c(0, 30000),
                     labels = label_number(big.mark = ",")) +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 30, hjust = 1)) +
  labs(x = "", y = "")

p2 = police_stops %>% 
  ggplot(aes(personSearch)) +
  geom_bar() +
  geom_text(aes(label = ..count..), stat = "count", vjust = -0.3) +
  scale_y_continuous(labels = label_number(big.mark = ",")) +
  theme_classic() +
  labs(x = "Person Search", y = "")

p3 = police_stops %>% 
  ggplot(aes(vehicleSearch)) +
  geom_bar() +
  geom_text(aes(label = ..count..), stat = "count", vjust = -0.3) +
  scale_y_continuous(labels = label_number(big.mark = ",")) +
  theme_classic() +
  labs(x = "Vehicle Search", y = "")

# Combine plots and annotate
(p2 | p3) / 
  p1 + plot_annotation(title = "Subcategories of Police Stops and Violence in Minneapolis",
                       caption = "Source: Kaggle")

# Save png
ggsave("minneapolis-police-stops-and-violence/figures/police-force-subcategories.png", width = 8, height = 9)
