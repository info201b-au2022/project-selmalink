library(shiny)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)

intro_panel <- tabPanel(
  "Introduction"
)

second_panel <- tabPanel(
  "first visualization"
)

third_panel <- tabPanel(
  "second visualization",
  
  fluidPage(
  selectInput("select", label = h3("Select box"), 
              choices = list("Never" = 1, "Rarely" = 2, "Sometimes" = 3, "Frequently" = 4, "Always" = 5 ), 
              selected = 1),
  
  fluidRow(column(3, verbatimTextOutput("value"))),
  
  plotOutput("piechart")

  )
)



fourth_panel <- tabPanel(
  "third visualization"
)

fifth_panel <- tabPanel(
  "summary"
)

sixth_panel <- tabPanel(
  "report"
)

ui <- fluidPage(
    navbarPage(
      title = "Covid 19 and political leaning",
      intro_panel,
      second_panel,
      third_panel,
      fourth_panel,
      fifth_panel,
      sixth_panel
    )
  )
  

