source("questions/pkgs.R")

q7entry <- "


```{r}
ggplot(data = covid_map, aes(x = ___, y = ___, group = ___, fill = ___)) +
  geom_polygon(colour = 'white') +
  coord_quickmap()

```
"

q7sol <- "


```{r}
ggplot(data = covid_map, aes(x = long, y = lat, group = group, fill = deaths_cumulative_total)) +
  geom_polygon(colour = 'white') +
  coord_quickmap()

```
"


q7 <- tagList(
  p(strong("Q7: "), ("create a map that shows total deaths of each country."), em(span(textOutput("Hint: "), style="color:red")),
    "The variable you need is ", em("`deaths_cumulative_total`.")),
  # User enter code - UI
  aceEditor("Q7", mode = "r", value = q7entry),
  actionButton("eval7", "Submit"),
  shinycssloaders::withSpinner(htmlOutput("q7output")),


  br(),
  br(),
  actionButton("btn8", "Solution"),
  # hidden(div(id = "pSolution6",
  #            shinycssloaders::withSpinner(plotOutput("pSol6")))),
  hr()

)
