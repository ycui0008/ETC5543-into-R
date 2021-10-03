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
library(shinyjs)
library(gradethis)
library(skimr)

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
    useShinyjs(),

    titlePanel("ggplotIntro"),

    navlistPanel(
        "Let's start",
        tabPanel("1: Understand your data",
                 p("A data set has its own", strong("characteristics"),
                   ": observations (rows), variables (columns), variables types, and missing values."),
                 br(),
                 "For a data set built in a package, it has description about its data source and variables.",
                 hr(),
                 h3("First,"),
                 div(HTML("Try to type <em>`?mtcars`</em> in the console")),
                 p("In your", em("help"),"panel will show the same thing as the screenshot below"),
                 br(),
                 br(),
                 img(src = 'mtcars.PNG', align = "left"),
                 br(),
                 br(),
                 "This step is important before drawing any plots,
                 because different types of plots are suitable for different types of variable.",
                 hr(),
                 h3("Second,"),
                 p("Use", em("skimr::skim()"), "or", em("summary()"), "function to have a first look of your data."),
                 img(src = 'summary mtcars.PNG', align = 'left'),
                 br(),
                 br(),
                 h3("Let's start with an easy example")
                 ),

        tabPanel("2: Simple example",
                 h4("Play around with the variables:"),
                 varSelectInput("mtcars_x", label= h5("Select X-axis variable:"), mtcars,
                              # choices = list("mpg", "cyl", "disp", "hp", "drat", "wt", "qsec", "vs", "am", "gear", "carb"),
                              selected = "cyl"
                              ),
                 varSelectInput("mtcars_y", label= h5("Select Y-axis variable:"), mtcars,
                              # choices = list("mpg", "cyl", "disp", "hp", "drat", "wt", "qsec", "vs", "am", "gear", "carb"),
                              selected = "hp"
                              ),
                 # radioButtons("mtcars_geom", label = h5("select the plot type"),
                 #              choices = list("geom_point()", "geom_jitter()"),
                 #              selected = "geom_point()"),
                 verbatimTextOutput("eg1"),
                 plotOutput("egPlot1"),
                 p("Now, you can understand the basic algorithm of ", em("ggplot.")),
                 p("Within ", em("aes()"),
                   ", the x and y are standing for x-axis variable and y-axis variable, respectively."),
                 p(em("geom_point()")," is used to create scatterplots."),
                 p("You can click the link below to check all types of", em("ggplot2"), "layers"),
                 uiOutput("reference")),

        tabPanel("3: Simple exercises",
                 p("Now, let's do some simple exercises. We are going to use ",
                   em("diamonds"),
                   "data set."),
                 p(strong("Q1: "),"understand your data set."),
                 # learner enter code here
                 textInput("simpleEx1",
                           label = h4("Enter your code here:"),
                           value = "diamonds"),
                 verbatimTextOutput("Ex1sol"),

                 br(),
                 br(),
                 actionButton("btn1", "Hint"),
                 hidden(div(id = "hint1",
                            verbatimTextOutput("ht1"))),
                 br(),
                 br(),
                 actionButton("btn2", "Solution"),
                 hidden(div(id = "hint2",
                            verbatimTextOutput("ht2"))),
                 p("Remember: you can always use ", em("?diamonds"), " to read more information about the data set."),
                 hr(),
                 # Plot section
                 h4("Make a simple plot."),
                 p(strong("Q2: "), "Make a plot depicting price against carat. Use scatterplot."),
                 p("Conventionally speaking, Vertical axis (y) ",
                   span(strong("against / versus "), style = "color: red"), # change text colour in red
                   "Horizontal axis (x)."),
                 actionButton("btn3", "Sample Plot"),
                 hidden(div(id = "pSolution1",
                            plotOutput("pSol1"))),

                 # carat against cut
                 h5(strong("Note: "), "now, we are only dealing with numeric variables; let's try to plot character variables."),
                 p(strong("Q3: "), "Make a plot depicting carat against cut Use scatterplot."),

                 actionButton("btn4", "Sample Plot"),
                 hidden(div(id = "pSolution2",
                            plotOutput("pSol2"))),
                 p("This plot is not informative, because many points are overlapping and we cannot know how many observations
                   in each", em(" cut")," group."),
                 p("Now, we can use ", em("geom_jitter() or geom_boxplot()"), " to make better plot."),
                 verbatimTextOutput("jittercode"),
                 plotOutput("jitterexample"),
                 verbatimTextOutput("boxcode"),
                 plotOutput("boxexample")
                 ),
        tabPanel("4. Colour"),
        "-----",
        tabPanel("Component 5")
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    # ggplot layers link
    url <- a("Click here", href="https://ggplot2.tidyverse.org/reference/index.html")
    output$reference <- renderUI({
        tagList(url)
    })

    # mtcars example text part

    output$eg1 <- renderPrint({
        cat("mtcars %>%",
            "ggplot(aes(x = ", input$mtcars_x, ", y = ", input$mtcars_y,")) + geom_point()"
            )
    })


    # mtcars example plot output
    output$egPlot1 <- renderPlot({
        vx <- input$mtcars_x
        vy <- input$mtcars_y

        p1 <- ggplot(data = mtcars, aes(x = {{vx}}, y = {{vy}}))

        p1 + geom_point()

    })

    # simple example section
    output$Ex1sol <- renderPrint({
        eval(parse(text = input$simpleEx1), envir = environment())

        # eval(grade_this({
        #     if (identical(input$simpleEx1, "summary(mtcars)")){
        #         pass("Great work!")
        #     }
        #     fail("Retry.")
        # }), envir = environment())

        # grade_this_code()(
        #     eval(mock_this_exercise(
        #         .user_code     = input$simpleEx1, # user's code
        #         .solution_code = "summary(mtcars)"  # solution
        #     ),envir = environment())
        # )
    })


    # Hint 1 text
    observeEvent(input$btn1, {
        toggle('hint1')
        output$ht1 <- renderText({"Use summary() or skimr::skim()"})
    })

    # Solution 1 text

    observeEvent(input$btn2, {
        toggle('hint2')
        output$ht2 <- renderText({
            "summary(diamonds) or skimr::skim(diamonds)"
            })
    })


    # Sample plot1

    observeEvent(input$btn3, {
        toggle('pSolution1')
        output$pSol1 <- renderPlot({
            diamonds %>%
                ggplot(aes(x = carat, y = price)) +
                geom_point()
        })
    })

    # Sample plot2

    observeEvent(input$btn4, {
        toggle('pSolution2')
        output$pSol2 <- renderPlot({
            diamonds %>%
                ggplot(aes(x = cut, y = carat)) +
                geom_point()
        })
    })

    # Code: jitter and boxplot for diamonds

    output$jittercode <- renderPrint({
        cat(paste("diamonds %>% ",
               "    ggplot(aes(x = cut, y = carat)) +",
               "    geom_jitter(alpha = 0.5)  # alpha is a argument to control transparency",
               sep = '\n'))
    })

    output$jitterexample <- renderPlot({
        diamonds %>%
            ggplot(aes(x = cut, y = carat)) +
            geom_jitter(alpha = 0.5)
    })

    output$boxcode <- renderPrint({
        cat(paste("diamonds %>% ",
                  "    ggplot(aes(x = cut, y = carat)) +",
                  "    geom_boxplot()",
                  sep = '\n'))
    })

    output$boxexample <- renderPlot({
        diamonds %>%
            ggplot(aes(x = cut, y = carat)) +
            geom_boxplot()
    })


}

# Run the application
shinyApp(ui = ui, server = server)
