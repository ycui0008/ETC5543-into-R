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
library(shinyAce)

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

score <- 0

q1entry <- "
```{r}
diamonds
```
"

q2entry <- "


```{r}
diamonds %>%
    ggplot(aes(x = ___, y = ___)) +
    geom_point()
```
"

q2sol <- "


```{r}
diamonds %>%
    ggplot(aes(x = cut, y = carat)) +
    geom_point()
```
"

q3entry <- "


```{r}
diamonds %>%
    ggplot(aes(x = ___, y = ___)) +
    geom_point()

```
"


# Define UI for application that draws a histogram
ui <- fluidPage(
    useShinyjs(),

    titlePanel("ggplotIntro"),

    navlistPanel(
        "Let's start",
        tabPanel("1: Understand your data",
                 includeMarkdown("First section.md")
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
                 radioButtons("mtcars_geom", label = h5("select the plot type"),
                              choices = list("geom_point()", "geom_jitter()", "geom_boxplot()", "geom_line()"),
                              selected = "geom_point()"),
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
                 # Q1
                 p(strong("Q1: "),"understand your data set."),
                 # textInput("simpleEx1",
                 #           label = h4("Enter your code here:"),
                 #           value = "diamonds"),
                 # verbatimTextOutput("Ex1sol"),

                 # User enter code - UI
                 aceEditor("Q1", mode = "r", value = q1entry),
                 actionButton("eval1", "Submit"),
                 shinycssloaders::withSpinner(htmlOutput("q1output")),


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

                 # Q2
                 h4("Make a simple plot."),
                 p(strong("Q2: "), "Make a plot depicting price against carat. Use scatterplot (fill in the blanks)."),
                 p("Conventionally speaking, Vertical axis (y) ",
                   span(strong("against / versus "), style = "color: red"), # change text colour in red
                   "Horizontal axis (x)."),

                 # User enter code - UI
                 aceEditor("Q2", mode = "r", value = q2entry),
                 actionButton("eval2", "Submit"),
                 shinycssloaders::withSpinner(htmlOutput("q2output")),
                 htmlOutput("q2compare"),

                 actionButton("btn3", "Solution"),
                 hidden(div(id = "pSolution1",
                            plotOutput("pSol1"))),
                 hr(),

                 # Q3: carat against cut
                 h5(strong("Note: "), "now, we are only dealing with numeric variables; let's try to plot character variables."),
                 p(strong("Q3: "), "Make a plot depicting carat against cut Use scatterplot (fill in the blanks)."),

                 # User enter code - UI
                 aceEditor("Q3", mode = "r", value = q3entry),
                 actionButton("eval3", "Submit"),
                 shinycssloaders::withSpinner(htmlOutput("q3output")),

                 actionButton("btn4", "Solution"),
                 hidden(div(id = "pSolution2",
                            plotOutput("pSol2"))),

                 # Improvement -- geom_boxplot() or geom_jitter()

                 p("This plot is not informative, because many points are overlapping and we cannot know how many observations
                   in each", em(" cut")," group."),
                 p("Now, we can use ", em("geom_jitter() or geom_boxplot()"), " to make better plot."),

                 verbatimTextOutput("jittercode"),
                 plotOutput("jitterexample"),

                 verbatimTextOutput("boxcode"),
                 plotOutput("boxexample")
                 ),
        tabPanel("4. Colour or Shape",
                 includeHTML("Colour.html"),
                 hr(),
                 h4("Example"),
                 verbatimTextOutput("sccode1"),
                 plotOutput("scexample1"),
                 p("Here, we use colour to represent the types of engine. 0 is V-shaped engine, while 1 is straight engine."),
                 hr(),
                 h3("Simple exercises")

                 ),
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
        cat(paste("mtcars %>%",
            paste0("    ggplot(aes(x = ", input$mtcars_x, ", y = ", input$mtcars_y, ")) +"),
            paste0("    ",input$mtcars_geom), sep = '\n'))
    })


    # mtcars example plot output
    output$egPlot1 <- renderPlot({
        vx <- input$mtcars_x
        vy <- input$mtcars_y

        p1 <- ggplot(data = mtcars, aes(x = {
            {
                vx
            }
        }, y = {
            {
                vy
            }
        }))

        # if (input$mtcars_geom == "geom_point()") {
        #     p1 + geom_point()
        # } else if (input$mtcars_geom == "geom_jitter()"){
        #     p1 + geom_jitter()
        # }

        p1 + eval(parse(text = input$mtcars_geom))


    })

    # simple example section
    output$Ex1sol <- renderPrint({
        eval(parse(text = input$simpleEx1), envir = environment())
    })


    # Hint 1 text
    observeEvent(input$btn1, {
        toggle('hint1')
        output$ht1 <- renderText({"Use summary() or skimr::skim()"})
    })

    # Q1 output
    output$q1output <- renderUI({
        input$eval1
        HTML(knitr::knit2html(text = isolate(input$Q1), fragment.only = TRUE, quiet = TRUE))
    })

    # Solution 1 text

    observeEvent(input$btn2, {
        toggle('hint2')
        output$ht2 <- renderText({
            "summary(diamonds) or skimr::skim(diamonds)"
            })
    })

    # Q2 output
    output$q2output <- renderUI({
        input$eval2
        HTML(knitr::knit2html(text = isolate(input$Q2), fragment.only = TRUE, quiet = TRUE))
    })

    output$q2compare <- renderUI({
        input$eval2
        if (input$Q2 == q2sol) {
            "Success"

        } else {
            "Wrong"
        }
    })

    q2score <- reactive({
      input$eval2
        if (input$Q2 == q2sol)

    })


    # Q2: Sample plot1

    observeEvent(input$btn3, {
        toggle('pSolution1')
        output$pSol1 <- renderPlot({
            diamonds %>%
                ggplot(aes(x = carat, y = price)) +
                geom_point()
        })
    })

    # Q3 output
    output$q3output <- renderUI({
        input$eval3
        HTML(knitr::knit2html(text = isolate(input$Q3), fragment.only = TRUE, quiet = TRUE))
    })

    # Q3: Sample plot2

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

    # Colour section ---

    output$sccode1 <- renderPrint({
        cat(paste("mtcars %>% ",
                  "    ggplot(aes(x = cyl, y = hp, colour = factor(vs))) +",
                  "    geom_point()",
                  sep = '\n'))
    })

    output$scexample1 <- renderPlot({
        mtcars %>%
            ggplot(aes(
                x = cyl,
                y = hp,
                colour = factor(vs)
            )) +
            geom_point()
    })

}

# Run the application
shinyApp(ui = ui, server = server)
