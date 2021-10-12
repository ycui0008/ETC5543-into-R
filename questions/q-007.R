source(here::here("questions/pkgs.R"))


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
question <- tagList(
  p(strong("Q7: "), ("create"))

)
