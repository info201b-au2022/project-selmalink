library(shiny)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)

shiny_state_df <- function() {
  mask_df <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/mask-use-by-county.csv")
  state_df <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/Vaccine_Hesitancy_for_COVID-19__County_and_local_estimates.csv")
  state_df <- state_df %>%
    select(c("FIPS.Code", "State"))
  mask_df <- mask_df %>%
    left_join(state_df, by=c("COUNTYFP" = "FIPS.Code")) %>%
    group_by(State) %>%
    summarize(Never = mean(NEVER, na.rm=TRUE),
              Rarely = mean(RARELY, na.rm=TRUE),
              Sometimes = mean(SOMETIMES, na.rm=TRUE),
              Frequently = mean(FREQUENTLY, na.rm=TRUE)
    ) %>%
    ungroup()
}

source("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/source/aggregate_table.R")

server <- function(input, output) {

  output$piechart <- renderPlot ({
  #make_pie_chart <-
    covid <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/mask-use-by-county.csv")
    
    national_mask_use <- covid %>%
      select(c("Never", "Rarely", "Sometimes", "Frequently", "Always")) %>%
      colMeans()
    
    lbls <- c("Never", "Rarely", "Sometimes", "Frequently", "Always")
    pct <- round(national_mask_use/sum(national_mask_use)*100)
    lbls <- paste(lbls, pct)
    lbls <- paste0(lbls, "%")
    pie(national_mask_use, labels = lbls, col = rainbow(length(lbls)),
        main="National Mask Usage During COVID Pandemic")
  })
  
  
  state_death_data <- reactive({
    final_aggregate_df %>%
    filter(deaths_per_100000 > input$mindepth) %>%
    filter(deaths_per_100000 < input$maxdepth) %>%
    select(c("deaths_per_100000", "State"))
})

  output$plot <- renderPlot({

    ggplot(state_death_data()) +
      geom_col(mapping = aes(deaths_per_100000, reorder(State, -deaths_per_100000), fill = deaths_per_100000)) +
      #xlim(input$mindepth, input$maxdepth) +
      labs(title="Histogram for COVID Death Rates by State") +
      labs(x="COVID Deaths per 100,000", y="States")
  })
  
}








