source("questions/pkgs.R")

q1entry <- "
```{r}
diamonds
```
"

q1sol <- "
```{r}
summary(diamonds)
```
"

q1 <- tagList(
  p(strong("Q1: "),"understand your data set."),
  # textInput("simpleEx1",
  #           label = h4("Enter your code here:"),
  #           value = "diamonds"),
  # verbatimTextOutput("Ex1sol"),

  # User enter code - UI
  aceEditor("Q1", mode = "r", value = q1entry),
  actionButton("eval1", "Submit"),
  shinycssloaders::withSpinner(htmlOutput("q1output")),
  htmlOutput("q1compare"),


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
  hr()
)

# saveRDS(question, here::here("test/questions-ui/q-001.rds"))

