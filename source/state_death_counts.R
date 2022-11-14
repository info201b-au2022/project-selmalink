library(tidyverse)

source("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/source/aggregate_table.R")

View(final_aggregate_df)

state_death_counts <- final_aggregate_df %>%
  select(State, deaths_per_1000000)
