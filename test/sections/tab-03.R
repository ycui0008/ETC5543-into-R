
# q1 <- readRDS("questions-ui/q-001.rds")
# q2 <- readRDS("questions-ui/q-002.rds")
# q3 <- readRDS("questions-ui/q-003.rds")

for(i in 1:3) {
  source(paste0("questions/q-",stringr::str_pad(i, 3, side = "left", pad = "0"), ".R"))
}
# source("questions/q-001.R")
# source("questions/q-002.R")
# source("questions/q-003.R")



# source("questions-ui/q-001.R")

tab03 <- tabPanel("3: Simple exercises",
         p("Now, let's do some simple exercises. We are going to use ",
           em("diamonds"),
           "data set."),
         # Q1
         q1,
         # source("questions/q-001.R"),
         # source("questions/q-002.R"),
         # source("questions/q-003.R"),
         # Q2
         q2,
         # Q3: carat against cut
         q3,
         actionButton("score_btn_1", "Show total score in this section"),
         uiOutput("sum_score_tab3"))
