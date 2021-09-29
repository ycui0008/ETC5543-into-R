#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny) # Import
library(datasets) # Import
library(readr) # Import
library(ggplot2) # Import
library(magrittr) # Import

url <- 'https://covid19.who.int/WHO-COVID-19-global-table-data.csv'

who_covid <- read_csv(url) %>%
    janitor::clean_names() %>%
    dplyr::select(
        name,
        who_region,
        cases_cumulative_total,
        cases_cumulative_total_per_100000_population,
        deaths_cumulative_total,
        deaths_cumulative_total_per_100000_population
    )



# Define UI for application that draws a histogram
ui <- fluidPage(

    titlePanel("Application Title"),

    navlistPanel(
        "Header A",
        tabPanel("Component 1"),
        tabPanel("Component 2"),
        "Header B",
        tabPanel("Component 3"),
        tabPanel("Component 4"),
        "-----",
        tabPanel("Component 5")
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application
shinyApp(ui = ui, server = server)
