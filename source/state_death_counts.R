library(tidyverse)

source("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/source/aggregate_table.R")

state_death_counts <- final_aggregate_df %>%
  select(c("deaths_per_100000", "State"))

death_count_plot <- function() {
  ggplot(data = state_death_counts) +
    geom_col(mapping = aes(deaths_per_100000 , reorder(State, -deaths_per_100000))) +
    labs(title="Histogram for COVID Death Rates by State") +
    labs(x="COVID Deaths per 100,000", y="States")
}