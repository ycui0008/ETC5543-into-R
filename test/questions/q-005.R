source("questions/pkgs.R")

q5entry <- "


```{r}
ggplot(data = top3_txhousing, aes(x = ___, y = ___, ___ = ___)) +
  geom_col()

```
"

q5sol <- "


```{r}
ggplot(data = top3_txhousing, aes(x = month, y = tot_sales, fill = city)) +
  geom_col()

```
"


q5 <- tagList(
  includeHTML("txhousing.html"),
  p(strong("Q5: "),
    "Make a plot depicting monthly total sales and use colour to represent different cities. Use bar chart (fill in the blanks)."),


  # User enter code - UI
  aceEditor("Q5", mode = "r", value = q5entry),
  actionButton("eval5", "Submit"),
  shinycssloaders::withSpinner(htmlOutput("q5output")),


  br(),
  br(),
  actionButton("btn6", "Solution"),
  hidden(div(id = "pSolution4",
             shinycssloaders::withSpinner(plotOutput("pSol4")))),
  hr()
)

# saveRDS(question, here::here("test/questions-ui/q-004.rds"))

