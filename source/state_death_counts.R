library(tidyverse)

source("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/source/aggregate_table.R")

View(final_aggregate_df)

#state_death_counts <- final_df %>%
#  select(State, Deaths.involving.COVID.19)%>%
#  drop_na() %>%
#  group_by(State) %>%
#  summarise(death_count_each_state = sum(Deaths.involving.COVID.19))

state_death_counts <- final_aggregate_df %>%
  select(State, deaths_per_1000000)

ggplot(data = state_death_counts) +
  geom_col(mapping = aes(x = deaths_per_1000000 , y = State))
