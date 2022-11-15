library(ggplot2)
library(GGally)

source("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/source/aggregate_table.R")

matrix_df <- final_aggregate_df %>%
  select(c("biden_percent", "trump_percent", "low_mask", "vaccine_hesitant", "deaths_per_100000"))

matrix_plot <- function() {
  ggpairs(
    matrix_df,
    title = "Scatter Plot Matrix for COVID and 2020 Election Data in US States",
    upper = list(continuous = wrap(ggally_cor, display_grid = FALSE)),
    diag = list(continuous = wrap("barDiag")),
    proportions = "auto",
    columnLabels = c(
      "Votes for Biden (%)",
      "Votes for Trump (%)",
      "Low Mask Use (%)", 
      "Vaccine Hesitancy (%)",
      "Deaths (per 100,000)"
    )
  )
}
