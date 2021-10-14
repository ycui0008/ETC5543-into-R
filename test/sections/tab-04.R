# q4 <- readRDS("questions-ui/q-004.rds")
# q5 <- readRDS("questions-ui/q-005.rds")
# q6 <- readRDS("questions-ui/q-006.rds")
# for(i in 4) {
# source("questions/q-004.R")
# }
source("questions/q-004.R")
source("questions/q-005.R")

tab04 <- tabPanel("4. Colour or Shape",
         includeHTML("Colour.html"),
         hr(),
         h4("Example"),
         verbatimTextOutput("sccode1"),
         plotOutput("scexample1"),
         p("Here, we use colour to represent the types of engine. 0 is V-shaped engine, while 1 is straight engine."),
         hr(),
         h3("Simple exercises"),
         # q4
         q4,
         q5,
         actionButton("score_btn_2", "Show your scores in this section")
         )
