source(here::here("questions/pkgs.R"))

q4entry <- "


```{r}
ggplot(data = mtcars, aes(x = ___, y = ___, colour = ___)) +
    geom_point()

```
"

q4sol <- "


```{r}
ggplot(data = mtcars, aes(x = mpg, y = hp, colour = wt)) +
    geom_point()

```
"

question <- tagList(
  p(strong("Q4: "),"Make a plot depicting hp against mpg and colouring wt. Use scatterplot (fill in the blanks)."),


  # User enter code - UI
  aceEditor("Q4", mode = "r", value = q4entry),
  actionButton("eval4", "Submit"),
  shinycssloaders::withSpinner(htmlOutput("q4output")),
  htmlOutput("q4compare"),

  br(),
  br(),
  actionButton("btn5", "Solution"),
  hidden(div(id = "pSolution3",
             shinycssloaders::withSpinner(plotOutput("pSol3")))),
  hr()
)

saveRDS(question, here::here("test/questions-ui/q-004.rds"))

