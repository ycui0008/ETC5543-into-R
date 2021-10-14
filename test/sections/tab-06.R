# q7 <- readRDS("questions-ui/q-007.rds")

source("questions/q-007.R")
source("questions/q-008.R")

tab06 <- tabPanel("6. Introduction of Polygon",
                  includeHTML("tab05.html"),
                  h3("Now, let try two simple exercises."),
                  q7,
                  q8,
                  actionButton("score_btn_4", "Show your scores in this section")
                  )
