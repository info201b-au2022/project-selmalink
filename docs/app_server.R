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
  
}








