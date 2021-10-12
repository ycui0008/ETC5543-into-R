q4 <- readRDS("questions-ui/q-004.rds")
# q2 <- readRDS("questions-ui/q-002.rds")
# q3 <- readRDS("questions-ui/q-003.rds")


tab04 <- tabPanel("4. Colour or Shape",
         includeHTML("Colour.html"),
         hr(),
         h4("Example"),
         verbatimTextOutput("sccode1"),
         plotOutput("scexample1"),
         p("Here, we use colour to represent the types of engine. 0 is V-shaped engine, while 1 is straight engine."),
         hr(),
         h3("Simple exercises"),
         q4
         )
