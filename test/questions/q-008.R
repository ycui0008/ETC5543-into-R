source("questions/pkgs.R")

q8entry <- "


```{r}
ggplot(GDP_clean, aes(___, ___, ___ = ___, ___ = ___)) +
  geom_polygon(colour = 'white') +
  coord_quickmap()

```
"

q8sol <- "


```{r}
ggplot(GDP_clean, aes(long, lat, group = group, fill = GDP)) +
  geom_polygon(colour = 'white') +
  coord_quickmap()

```
"


q8 <- tagList(
  p(strong("Q8: "), ("create a map that shows total deaths of each country.")),
  # User enter code - UI
  aceEditor("Q8", mode = "r", value = q8entry),
  actionButton("eval8", "Submit"),
  shinycssloaders::withSpinner(htmlOutput("q8output")),


  br(),
  br(),
  actionButton("btn9", "Solution"),
  hidden(div(id = "pSolution7",
             shinycssloaders::withSpinner(plotOutput("pSol7")))),
  hr()

)
