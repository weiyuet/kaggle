# Load libraries
library(tidyverse)
library(scales)

# Load data
athlete_count <- read_csv("commonwealth-games-2022/data/Countrywise Athlete Count.csv")

medal_standings <- read_csv("commonwealth-games-2022/data/Medal Standings.csv")

# Plot countries with the most and least number of participating athletes
athlete_count %>% 
  slice_max(Athletes, n = 10) %>% 
  ggplot(aes(x = Country, y = Athletes)) +
  geom_col(fill = "dodgerblue3") +
  scale_y_continuous(limits = c(0, 450),
                     breaks = seq(0, 450, 50),
                     expand = c(0, 0)) +
  theme_classic() +
  labs(x = "", y = "",
       title = "Countries with the Most Participating Athletes (Top 10)",
       subtitle = "Commonwealth Games 2022",
       caption = "Source: www.birmingham2022.com")

# Save png
ggsave("commonwealth-games-2022/figures/countries-most-athletes.png", width = 7, height = 5)

# Join athlete count and medal standings data sets
# Change column name in medal standings Country Name to Country
colnames(medal_standings)[colnames(medal_standings) == "Country Name"] <- "Country"

medal_standings %>% left_join(athlete_count) %>% 
  drop_na() %>%
  ggplot(aes(x = `Total Gold`, y = Athletes, colour = Country)) + 
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  theme_classic() +
  theme(legend.position = "none")

# Save png
ggsave("commonwealth-games-2022/figures/total-gold-country.png", width = 6, height = 6)