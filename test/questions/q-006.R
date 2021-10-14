source("questions/pkgs.R")

q6entry <- "


```{r}
ggplot(mtcars, aes(x = cyl, y = hp)) +
  geom_point() +
  ___(___ = \"Relationship between Gross horsepower and Number of Cylinders for 32 automobiles in 1974\",
       ___ = \"Number of Cylinders\",
       ___ = \"Gross horsepower\")

```
"

q6sol <- "


```{r}
ggplot(mtcars, aes(x = cyl, y = hp)) +
  geom_point() +
  labs(title = \"Relationship between Gross horsepower and Number of Cylinders for 32 automobiles in 1974\",
       x = \"Number of Cylinders\",
       y = \"Gross horsepower\")

```
"


q6 <- tagList(
  # User enter code - UI
  aceEditor("Q6", mode = "r", value = q6entry),
  actionButton("eval6", "Submit"),
  shinycssloaders::withSpinner(htmlOutput("q6output")),


  br(),
  br(),
  actionButton("btn7", "Solution"),
  hidden(div(id = "pSolution5",
             shinycssloaders::withSpinner(plotOutput("pSol5")))),
  hr()
)

# saveRDS(question, here::here("test/questions-ui/q-004.rds"))

