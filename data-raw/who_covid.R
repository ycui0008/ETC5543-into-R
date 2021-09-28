## code to prepare `who_covid` dataset goes here
library(readr)
library(janitor)

url <- 'https://covid19.who.int/WHO-COVID-19-global-table-data.csv'

who_covid <- read_csv(url) %>%
  clean_names() %>%
  dplyr::select(
    name,
    who_region,
    cases_cumulative_total,
    cases_cumulative_total_per_100000_population,
    deaths_cumulative_total,
    deaths_cumulative_total_per_100000_population
  )

usethis::use_data(who_covid, overwrite = TRUE)
