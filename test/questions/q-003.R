source("questions/pkgs.R")

q3entry <- "


```{r}
ggplot(data = head(diamonds,1000), aes(x = ___, y = ___)) +
    geom_point()

```
"

q3sol <- "


```{r}
ggplot(data = head(diamonds,1000), aes(x = cut, y = carat)) +
    geom_point()

```
"

q3 <- tagList(
  h5(strong("Note: "), "now, we are only dealing with numeric variables; let's try to plot character variables."),
  p(strong("Q3: "), "Make a plot depicting carat against cut Use scatterplot (fill in the blanks)."),

  # User enter code - UI
  aceEditor("Q3", mode = "r", value = q3entry),
  actionButton("eval3", "Submit"),
  shinycssloaders::withSpinner(htmlOutput("q3output")),
  htmlOutput("q3compare"),

  actionButton("btn4", "Solution"),
  hidden(div(id = "pSolution2",
             shinycssloaders::withSpinner(plotOutput("pSol2")))),

  # Improvement -- geom_boxplot() or geom_jitter()

  p("This plot is not informative, because many points are overlapping and we cannot know how many observations
                   in each", em(" cut")," group."),
  p("Now, we can use ", em("geom_jitter() or geom_boxplot()"), " to make better plot."),

  verbatimTextOutput("jittercode"),
  plotOutput("jitterexample"),

  verbatimTextOutput("boxcode"),
  plotOutput("boxexample")
)


# saveRDS(question, here::here("test/questions-ui/q-003.rds"))
