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

    titlePanel("ggplotIntro"),

    navlistPanel(
        "Let's start",
        tabPanel("Step 1: Understand your data",
                 "A data set has its own characteristics: observations (rows), variables (columns), variables types, and missing values.",
                 br(),
                 "For a data set built in a package, it has description about its data source and variables.",
                 div(HTML("Try to type <em>`?mtcars`</em> in the console")),
                 p("In your", em("help"),"panel will show the same thing as the screenshot below"),
                 img(src = 'mtcars.PNG', align = "left"),
                 br(),
                 "This step is important before drawing any plots, because different types of plots are suitable for different types of variable.",
                 ),
        tabPanel("Example",
                 p("You can click the link below to check all types of", em("ggplot2"), "layers"),
                 uiOutput("reference")),
        "",
        tabPanel("Component 3"),
        tabPanel("Component 4"),
        "-----",
        tabPanel("Component 5")
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    url <- a("Click here", href="https://ggplot2.tidyverse.org/reference/index.html")
    output$reference <- renderUI({
        tagList(url)
    })

    output$distPlot <- renderPlot({

    })
}

# Run the application
shinyApp(ui = ui, server = server)
