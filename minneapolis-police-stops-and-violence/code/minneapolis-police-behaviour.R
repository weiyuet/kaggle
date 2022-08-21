# Load libraries
library(tidyverse)
library(scales)
library(gridExtra)
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

# p4 = grid.arrange(arrangeGrob(p2, p3, ncol = 2, nrow = 1), 
#              p1, nrow = 2,
#              heights = c(1.6, 2.4))

p2 + p3 + p1 + plot_layout(ncol = 1)

ggsave("minneapolis-police-stops-and-violence/figures/police-force-subcategories.png", width = 6, height = 9)
