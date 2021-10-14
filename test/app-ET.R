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
library(tidyr)
library(skimr)
library(shinyAce)
library(dplyr)

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

world <- map_data('world')

covid <-
    mutate(who_covid, name = case_when(name == "United States of America" ~ "USA",
                                       name == "United Kingdom" ~ "UK",
                                       TRUE ~ name))

covid_map <- left_join(covid[-1,], world, by = c("name" = "region"))

# txhousing data
top3_cities <- txhousing %>%
    filter(year == 2000) %>% # filter out year 2000
    group_by(city) %>%
    summarise(tot_sales = sum(sales)) %>% # total sales in 2000
    top_n(3) %>% # filter out top 3 cities
    pull(city)


top3_txhousing <- txhousing %>%
    filter(year == 2000, city %in% top3_cities) %>% # filter out top 3 cities in 2000
    group_by(city, month) %>%
    summarise(tot_sales = sum(sales))

# GDP data
GDP <- read_csv("API_NY.GDP.PCAP.CD_DS2_en_csv_v2_3052522.csv", skip = 4,
                col_select = list(`Country Name`, `1960`:`2020`)) %>%
    janitor::clean_names() %>%
    mutate(country_name = case_when(country_name == "United Kingdom" ~ "UK",
                                    country_name == "United States" ~ "USA",
                                    TRUE ~ country_name))

names(GDP)[-1] <- substring(names(GDP)[-1], 2)

GDP_clean <- GDP %>%
    pivot_longer(cols = c(2:ncol(GDP)), names_to = "year", values_to = "GDP") %>%
    mutate(year = as.numeric(year))

# load tab sections

for(i in 1:6) {
    source(sprintf("sections/tab-%.2d.R", i))
}




score_q1 <- 0
score_q2 <- 0
score_q3 <- 0
score_q4 <- 0
score_q5 <- 0
score_q5 <- 0
score_q6 <- 0
score_q7 <- 0

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
        tab05,
        tab06

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

    # Modal dialog
    observeEvent(input$eval1, {
        if (input$Q1 == q1sol) {
            ModalTitle = "Success"
            ModalFooter = tagList(
                modalButton("Keep going")
            )
            score_q1 <<- 1

        } else {
            score_q1 <<- 0
            ModalTitle = "Wrong"
            ModalFooter = tagList(
                modalButton("Retry")
            )
        }
        showModal(modalDialog(
            title = ModalTitle,
            footer = ModalFooter
        ))

        # output$q1compare <- renderUI({
        #     if (input$Q1 == q1sol) {
        #         score_q1 <<- 1
        #         "Success"
        #     } else {
        #         score_q1 <<- 0
        #         "Wrong"
        #     }
        #     })

    })

    # output$q1compare <- renderUI({
    #     input$eval1
    #     if (input$Q1 == q1sol) {
    #         score_q1 <<- 1
    #         "Success"
    #     } else {
    #         score_q1 <<- 0
    #         "Wrong"
    #     }
    # })

    # Q2 output
    output$q2output <- renderUI({
        input$eval2
        HTML(knitr::knit2html(text = isolate(input$Q2), fragment.only = TRUE, quiet = TRUE))
    })

    # Modal dialog
    observeEvent(input$eval2, {
        if (input$Q2 == q2sol) {
            ModalTitle = "Success"
            ModalFooter = tagList(
                modalButton("Keep going")
            )
            score_q2 <<- 1

        } else {
            score_q2 <<- 0
            ModalTitle = "Wrong"
            ModalFooter = tagList(
                modalButton("Retry")
            )
        }
        showModal(modalDialog(
            title = ModalTitle,
            footer = ModalFooter
        ))
    })



    # output$q2compare <- renderUI({
    #     input$eval2
    #     isolate(if (input$Q2 == q2sol) {
    #         score_q2 <<- 1
    #         "Success"
    #     } else {
    #         score_q2 <<- 0
    #         "Wrong"
    #     })
    # })

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

    # Modal dialog
    observeEvent(input$eval3, {
        if (input$Q3 == q3sol) {
            ModalTitle = "Success"
            ModalFooter = tagList(
                modalButton("Keep going")
            )
            score_q3 <<- 1

        } else {
            score_q3 <<- 0
            ModalTitle = "Wrong"
            ModalFooter = tagList(
                modalButton("Retry")
            )
        }
        showModal(modalDialog(
            title = ModalTitle,
            footer = ModalFooter
        ))
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

    observeEvent(input$score_btn_1,{
        sum_score <- score_q1 + score_q2 + score_q3
        if (sum_score == 3) {
            title = "Congraduation!"
        } else {
            title = "Keep working!"
        }

        showModal(modalDialog(
            title = title,
            paste0("You get ",as.character(sum_score), "/3 in this section.")

        ))
        sum_score <- NULL
    })

    # output$sum_score_tab3<- renderUI({
    #     input$score_btn_1
    #         sum_score <- score_q1 + score_q2 + score_q3
    #     as.character(sum_score)
    # })

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

    observeEvent(input$eval4, {
        if (input$Q4 == q4sol) {
            ModalTitle = "Success"
            ModalFooter = tagList(
                modalButton("Keep going")
            )
            score_q4 <<- 1

        } else {
            score_q4 <<- 0
            ModalTitle = "Wrong"
            ModalFooter = tagList(
                modalButton("Retry")
            )
        }
        showModal(modalDialog(
            title = ModalTitle,
            footer = ModalFooter
        ))
        sum_score <- NULL
    })


    observeEvent(input$btn5, {
        toggle('pSolution3')
        output$pSol3 <- renderPlot({
            mtcars %>%
                ggplot(aes(x = mpg, y = hp, colour = wt)) +
                geom_point()
        })
    })

    # Q5
    output$q5output <- renderUI({
        input$eval5
        HTML(knitr::knit2html(text = isolate(input$Q5), fragment.only = TRUE, quiet = TRUE))
    })

    # Q5: Sample plot2

    observeEvent(input$eval5, {
        if (input$Q5 == q5sol) {
            ModalTitle = "Success"
            text = NULL
            ModalFooter = tagList(
                modalButton("Keep going")
            )
            score_q5 <<- 1

        } else {
            score_q5 <<- 0
            ModalTitle = "Wrong"
            text = "Try to use fill to replace colour."
            ModalFooter = tagList(
                modalButton("Retry")
            )
        }
        showModal(modalDialog(
            title = ModalTitle,
            text,
            footer = ModalFooter
        ))
        sum_score <- NULL
    })


    observeEvent(input$btn6, {
        toggle('pSolution4')
        output$pSol4 <- renderPlot({
            top3_cities <- txhousing %>%
                filter(year == 2000) %>% # filter out year 2000
                group_by(city) %>%
                summarise(tot_sales = sum(sales)) %>% # total sales in 2000
                top_n(3) %>% # filter out top 3 cities
                pull(city)


            txhousing %>%
                filter(year == 2000, city %in% top3_cities) %>%
                group_by(city, month) %>%
                summarise(tot_sales = sum(sales)) %>%
                ggplot(aes(x = month, y = tot_sales, fill = city)) +
                geom_col()
        })
    })


    # show sum of score for tab4
    observeEvent(input$score_btn_2,{
        sum_score <- score_q4 + score_q5

        if (sum_score == 2) {
            title = "Congraduation!"
        } else {
            title = "Keep working!"
        }

        showModal(modalDialog(
            title = title,
            paste0("You get ",as.character(sum_score), "/2 in this section.")
        ))
        sum_score <- NULL
    })

    # Q6
    output$q6output <- renderUI({
        input$eval6
        HTML(knitr::knit2html(text = isolate(input$Q6), fragment.only = TRUE, quiet = TRUE))
    })

    # Q6: Sample plot2

    observeEvent(input$eval6, {
        if (input$Q6 == q6sol) {
            ModalTitle = "Success"
            ModalFooter = tagList(
                modalButton("Keep going")
            )
            score_q6 <<- 1

        } else {
            score_q6 <<- 0
            ModalTitle = "Wrong"
            ModalFooter = tagList(
                modalButton("Retry")
            )
        }
        showModal(modalDialog(
            title = ModalTitle,
            footer = ModalFooter
        ))
        sum_score <- NULL
    })


    observeEvent(input$btn7, {
        toggle('pSolution5')
        output$pSol5 <- renderPlot({
            mtcars %>%
                ggplot(aes(x = cyl, y = hp)) +
                geom_point() +
                labs(title = "Relationship between Gross horsepower and Number of Cylinders for 32 automobiles in 1974",
                     x = "Number of Cylinders",
                     y = "Gross horsepower")
        })
    })

    # show sum of score for tab4
    observeEvent(input$score_btn_3,{
        sum_score <- score_q6

        if (sum_score == 1) {
            title = "Congraduation!"
        } else {
            title = "Keep working!"
        }

        showModal(modalDialog(
            title = title,
            paste0("You get ",as.character(sum_score), "/1 in this section.")
        ))
        sum_score <- NULL
    })

    # Q7

    output$q7output <- renderUI({
        input$eval7
        HTML(knitr::knit2html(text = isolate(input$Q7), fragment.only = TRUE, quiet = TRUE))
    })

    # Q7: Sample plot2

    observeEvent(input$eval7, {
        if (input$Q7 == q7sol) {
            ModalTitle = "Success"
            ModalFooter = tagList(
                modalButton("Keep going")
            )
            score_q7 <<- 1

        } else {
            score_q7 <<- 0
            ModalTitle = "Wrong"
            ModalFooter = tagList(
                modalButton("Retry")
            )
        }
        showModal(modalDialog(
            title = ModalTitle,
            footer = ModalFooter
        ))
    })

    observeEvent(input$btn8, {
        toggle('pSolution6')
        output$pSol6 <- renderPlot({
            ggplot(data = covid_map, aes(x = long, y = lat, group = group, fill = deaths_cumulative_total)) +
                geom_polygon(colour = 'white') +
                coord_quickmap()
        })
    })

    # show sum of score for tab6

    observeEvent(input$score_btn_4,{
        sum_score <- score_q7
        if (sum_score == 3) {
            title = "Congraduation!"
        } else {
            title = "Keep working!"
        }

        showModal(modalDialog(
            title = title,
            paste0("You get ",as.character(sum_score), "/3 in this section.")

        ))
        sum_score <- NULL
    })


}

# Run the application
shinyApp(ui = ui, server = server)
