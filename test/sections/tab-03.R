
# q1 <- readRDS("questions-ui/q-001.rds")
# q2 <- readRDS("questions-ui/q-002.rds")
# q3 <- readRDS("questions-ui/q-003.rds")

for(i in 1:3) {
  source(paste0("questions/q-",stringr::str_pad(i, 3, side = "left", pad = "0"), ".R"))
}




# source("questions-ui/q-001.R")

tab03 <- tabPanel("3: Simple exercises",
         p("Now, let's do some simple exercises. We are going to use ",
           em("diamonds"),
           "data set."),
         # Q1
         q1,
         # Q2
         q2,
         # Q3: carat against cut
         q3,
         actionButton("score_btn_1", "Show your scores in this section")
         )
