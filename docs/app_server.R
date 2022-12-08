library(shiny)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(GGally)

source("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/source/scatterplot_matrix.R")
source("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/source/aggregate_table.R")

mask_df <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/mask-use-by-county.csv")
state_df <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/Vaccine_Hesitancy_for_COVID-19__County_and_local_estimates.csv")
state_df <- state_df %>%
  select(c("FIPS.Code", "State"))
shiny_state_df <- mask_df %>%
    left_join(state_df, by=c("COUNTYFP" = "FIPS.Code")) %>%
    group_by(State) %>%
    summarize(Never = mean(NEVER, na.rm=TRUE),
              Rarely = mean(RARELY, na.rm=TRUE),
              Sometimes = mean(SOMETIMES, na.rm=TRUE),
              Frequently = mean(FREQUENTLY, na.rm=TRUE),
              Always = mean(ALWAYS, na.rm=TRUE)
    ) %>%
    ungroup()

server <- function(input, output) {
  
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

  # Function selects for state in reactive function
  state_mask_func <- reactive({
    return_vector <- shiny_state_df %>%
      filter(State == input$state) %>%
      select(c("Never", "Rarely", "Sometimes", "Frequently", "Always"))
  })
  
  # Function returns pie chart for mask usage depending on State selected
  output$piechart <- renderPlot ({
    #make_pie_chart <-
    state_usage <- state_mask_func()
    state_vect <- as.numeric(as.vector(state_usage[1,]))
    
    lbls <- c("Never", "Rarely", "Sometimes", "Frequently", "Always")
    pct <- round(state_vect/sum(state_vect)*100)
    lbls <- paste(lbls, pct)
    lbls <- paste0(lbls, "%")
    pie(state_vect, labels = lbls, col = rainbow(length(lbls)),
        main=paste(input$state, "Mask Usage During COVID Pandemic"))
  })

  # Functions pulls values corresponding to x value
  x_func <- reactive({
    matrix_df %>%
      pull(input$x_var)
  })

  # Functions pulls values corresponding to y value
  y_func <- reactive({
    matrix_df %>%
      pull(input$y_var)
  })
  
  # Plots scatter plot with given x and y value from app
  output$scat_plot <- renderPlot({
    ggplot(matrix_df, mapping = aes(x = x_func(), y = y_func())) + 
      geom_point() +
      geom_smooth() +
      labs( 
        title = paste(input$x_var, "v.s.", input$y_var, "by U.S. State (2020)"),
        x = toupper(input$x_var),
        y = toupper(input$y_var)
        )
  })
}
