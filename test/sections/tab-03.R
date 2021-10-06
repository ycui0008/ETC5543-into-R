
q1 <- readRDS("questions-ui/q-001.rds")
q2 <- readRDS("questions-ui/q-002.rds")
q3 <- readRDS("questions-ui/q-003.rds")

tab03 <- tabPanel("3: Simple exercises",
         p("Now, let's do some simple exercises. We are going to use ",
           em("diamonds"),
           "data set."),
         # Q1
         q1,
         # Q2
         q2,
         # Q3: carat against cut
         q3)
