# Load libraries
library(tidyverse)
library(scales)

# Load data
athlete_count <- read_csv("commonwealth-games-2022/data/Countrywise Athlete Count.csv")

medal_standings <- read_csv("commonwealth-games-2022/data/Medal Standings.csv")

# Plot countries with the most and least number of participating athletes
athlete_count %>%
  slice_max(Athletes, n = 10) %>%
  mutate(Country = fct_reorder(Country, Athletes)) %>%
  ggplot(aes(x = Country, y = Athletes)) +
  geom_col(fill = "gray35", colour = "gray10") +
  geom_label(aes(x = Country, y = Athletes, label = round(Athletes, 0)),
    hjust = 1,
    vjust = 0.5,
    colour = "white",
    fill = NA,
    label.size = NA,
    size = 3.5
  ) +
  coord_flip() +
  scale_y_continuous(
    limits = c(0, 450),
    breaks = seq(0, 450, 50),
    expand = c(0, 0)
  ) +
  theme_classic() +
  labs(
    x = "", y = "",
    title = "Commonwealth Games 2022",
    subtitle = "Countries with the Most Participating Athletes (Top 10)",
    caption = "Source: www.birmingham2022.com"
  )

# Save png
ggsave("commonwealth-games-2022/figures/countries-most-athletes.png", width = 7, height = 5)

# Join athlete count and medal standings data sets
# Change column name in medal standings Country Name to Country
colnames(medal_standings)[colnames(medal_standings) == "Country Name"] <- "Country"

medal_standings %>%
  left_join(athlete_count) %>%
  drop_na() %>%
  mutate(Country = fct_reorder(Country, Total)) %>% 
  ggplot(aes(x = Total, y = Country)) +
  geom_col(fill = "gray35", colour = "gray10") +
  scale_x_continuous(breaks = seq(0, 160, 20),
                     limits = c(0, 160),
                     expand = c(0, 0)) +
  theme_classic() +
  labs(x = "", y = "",
       title = "Commonwealth Games 2022",
       subtitle = "Countries with the Most Total Medals",
       caption = "Source: www.birmingham2022.com")

# Save png
ggsave("commonwealth-games-2022/figures/total-gold-country.png", width = 6, height = 6)
