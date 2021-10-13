source("questions/pkgs.R")

q2entry <- "


```{r}
ggplot(data = head(diamonds,1000), aes(x = ___, y = ___)) +
    geom_point()
```
"

q2sol <- "


```{r}
ggplot(data = head(diamonds,1000), aes(x = carat, y = price)) +
    geom_point()
```
"

q2 <- tagList(
  h4("Make a simple plot."),
  p(strong("Q2: "), "Make a plot depicting price against carat. Use scatterplot (fill in the blanks)."),
  p("Conventionally speaking, Vertical axis (y) ",
    span(strong("against / versus "), style = "color: red"), # change text colour in red
    "Horizontal axis (x)."),

  # User enter code - UI
  aceEditor("Q2", mode = "r", value = q2entry),
  actionButton("eval2", "Submit"),
  shinycssloaders::withSpinner(htmlOutput("q2output")),


  actionButton("btn3", "Solution"),
  hidden(div(id = "pSolution1",
             shinycssloaders::withSpinner(plotOutput("pSol1")))),
  hr()
)

# saveRDS(question, here::here("test/questions-ui/q-002.rds"))
