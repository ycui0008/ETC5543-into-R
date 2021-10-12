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

for(i in 1:5) {
    source(sprintf("sections/tab-%.2d.R", i))
}

score_q1 <- 0
score_q2 <- 0
score_q3 <- 0
score_q4 <- 0

# Define UI for application that draws a histogram
ui <- fluidPage(
    useShinyjs(),

    titlePanel("ggplotIntro"),

    navlistPanel(
        "Let's start",
        tab01,
        tab02,
        tab03,
        tab04,
        tab05

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
        cat(paste(paste0("ggplot(data = mtcars, aes(x = ", input$mtcars_x, ", y = ", input$mtcars_y, ")) +"),
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

    output$q1compare <- renderUI({
        input$eval1
        if (input$Q1 == q1sol) {
            score_q1 <<- 1
            "Success"
        } else {
            score_q1 <<- 0
            "Wrong"
        }
    })

    # Q2 output
    output$q2output <- renderUI({
        input$eval2
        HTML(knitr::knit2html(text = isolate(input$Q2), fragment.only = TRUE, quiet = TRUE))
    })

    output$q2compare <- renderUI({
        input$eval2
        if (input$Q2 == q2sol) {
            score_q2 <<- 1
            "Success"
        } else {
            score_q2 <<- 0
            "Wrong"
        }
    })

    # Q2: Sample plot1

    observeEvent(input$btn3, {
        toggle('pSolution1')
        output$pSol1 <- renderPlot({
            diamonds %>%
                head(1000) %>%
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
                head(1000) %>%
                ggplot(aes(x = cut, y = carat)) +
                geom_point()
        })
    })

    output$q3compare <- renderUI({
        input$eval3
        if (input$Q3 == q3sol) {
            score_q3 <<- 1
            "Success"
        } else {
            score_q3 <<- 0
            "Wrong"
        }
    })



    # Code: jitter and boxplot for diamonds

    output$jittercode <- renderPrint({
        cat(paste("ggplot(data = mtcars, aes(x = cut, y = carat)) +",
               "    geom_jitter(alpha = 0.5)  # alpha is a argument to control transparency",
               sep = '\n'))
    })

    output$jitterexample <- renderPlot({
        diamonds %>%
            ggplot(aes(x = cut, y = carat)) +
            geom_jitter(alpha = 0.5)
    })

    output$boxcode <- renderPrint({
        cat(paste("ggplot(data = diamonds, aes(x = cut, y = carat)) +",
                  "    geom_boxplot()",
                  sep = '\n'))
    })

    output$boxexample <- renderPlot({
        diamonds %>%
            ggplot(aes(x = cut, y = carat)) +
            geom_boxplot()
    })

    # show sum of score for tab3

    output$sum_score_tab3<- renderUI({
        input$score_btn_1
            sum_score <- score_q1 + score_q2 + score_q3
        as.character(sum_score)
    })

    # Colour section ---

    output$sccode1 <- renderPrint({
        cat(paste("ggplot(data = mtcars, aes(x = cyl, y = hp, colour = factor(vs))) +",
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


    # Q4
    output$q4output <- renderUI({
        input$eval4
        HTML(knitr::knit2html(text = isolate(input$Q4), fragment.only = TRUE, quiet = TRUE))
    })

    # Q4: Sample plot2

    output$q4compare <- renderUI({
        input$eval4
        if (input$Q4 == q4sol) {
            score_q4 <<- 1
            "Success"
        } else {
            score_q4 <<- 0
            "Wrong"
        }
    })

    observeEvent(input$btn5, {
        toggle('pSolution3')
        output$pSol3 <- renderPlot({
            mtcars %>%
                ggplot(aes(x = mpg, y = hp, colour = wt)) +
                geom_point()
        })
    })


    # show sum of score for tab4

    output$sum_score_tab4<- renderUI({
        input$score_btn_2
        sum_score <- score_q4 + score_q5 + score_q6
        as.character(sum_score)
    })


}

# Run the application
shinyApp(ui = ui, server = server)
