library(shiny)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)

server <- function(input, output) {

  # covid <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/mask-use-by-county.csv")
  # national_mask_use <- covid %>%
  #   select(c("NEVER", "RARELY", "SOMETIMES", "FREQUENTLY", "ALWAYS")) %>%
  #   colMeans()

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








