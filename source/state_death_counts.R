library(tidyverse)

source("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/source/aggregate_table.R")

state_death_counts <- final_aggregate_df %>%
  select(c("State", "deaths_per_100000"))

death_count_plot <- function() {
  ggplot(data = state_death_counts) +
    geom_col(mapping = aes(x = deaths_per_100000 , y = State))
}