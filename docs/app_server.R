library(shiny)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)

server <- function(input, output) {

  df <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/mask-use-by-county.csv")

  output$piechart <- renderPlot ({
  pie_graph <- plot_ly(df, labels = ~States, type = 'pie')
                       pie_graph <- pie_graph %>% layout(title = 'National Mask Usage During COVID Pandemic',
                                                         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                                                         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  })
  
}








