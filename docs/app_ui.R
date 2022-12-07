library(shiny)
library(tidyverse)
library(dplyr)
library(ggplot2)

intro_panel <- tabPanel(
  "Introduction"
)

second_panel <- tabPanel(
  "first visualization"
)

third_panel <- tabPanel(
  "second visualization"
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
  # Application title
#   titlePanel("Old Faithful Geyser Data"),
#   
#   # Sidebar with a slider input for number of bins 
#   sidebarLayout(
#     sidebarPanel(
#       sliderInput("bins",
#                   "Number of bins:",
#                   min = 1,
#                   max = 50,
#                   value = 30)
#     ),
#     
#     # Show a plot of the generated distribution
#     mainPanel(
#       plotOutput("distPlot")
#     )
#   )
# )