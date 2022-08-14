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
