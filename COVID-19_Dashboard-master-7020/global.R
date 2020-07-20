# ---- Loading libraries ----
library("shiny")
library("shinydashboard")
library("tidyverse")
library("leaflet")
library("plotly")
library("DT")
library("fs")
library("wbstats")
library("shinythemes")
library("COVID19")
library("nCov2019")
library("dplyr")
library("ggplot2")

source("utils.R", local = T)

downloadGithubData <- function() {
    covid_nation <- COVID19::covid19()
    covid_state <- COVID19::covid19(level = 2)
    write.csv(covid_nation, file = "./data/COVID-19.csv",quote =FALSE,row.names = FALSE)
    write.csv(covid_state, file = "./data/COVID-19_state.csv",quote =FALSE,row.names = FALSE)
}


updateData <- function() {
  if (as.Date(file.info("data/COVID-19.csv")$mtime) == Sys.Date()) {
    covid_nation <- read.csv("data/COVID-19.csv")
    covid_state <- read.csv("data/COVID-19_state.csv")
  } else {
    downloadGithubData()
  }
}

# Update with start of app
updateData()

# TODO: Still throws a warning but works for now
covid_nation <- read.csv("data/COVID-19.csv")
covid_state <- read.csv("data/COVID-19_state.csv")
covid_nation$date <- as.Date(covid_nation$date,format='%Y-%m-%d')
covid_state$date <- as.Date(covid_state$date,format='%Y-%m-%d')
covid_china <- get_nCov2019(lang = "en")

# Get latest data
current_date <- as.Date(max(covid_nation$date))
changed_date <- file_info("data/COVID-19.csv")$change_time

# Get evolution data by country
data_confirmed_sub <- covid_nation %>%
  group_by(id, date, latitude, longitude) %>%
  summarise("confirmed" = sum(confirmed, na.rm = T),
            "Population" = sum(population, na.rm = T))

data_recovered_sub <- covid_nation %>%
  group_by(id, date, latitude, longitude) %>%
  summarise("recovered" = sum(recovered, na.rm = T),
            "Population" = sum(population, na.rm = T))

data_deceased_sub <- covid_nation %>%
  group_by(id, date, latitude, longitude) %>%
  summarise("deceased" = sum(deaths, na.rm = T),
            "Population" = sum(population, na.rm = T))

data_evolution <- data_confirmed_sub %>%
  full_join(data_deceased_sub) %>%
  ungroup() %>%
  mutate(date = as.Date(date)) %>%
  arrange(date) %>%
  group_by(id, latitude, longitude) %>%
  mutate(
    recovered = lag(confirmed, 14, default = 0) - deceased,
    recovered = ifelse(recovered > 0, recovered, 0),
    active = confirmed - recovered - deceased
  ) %>%
  pivot_longer(names_to = "var", cols = c(confirmed, recovered, deceased, active)) %>%
  ungroup()

# Calculating new cases
data_evolution <- data_evolution %>%
  group_by(id) %>%
  mutate(value_new = value - lag(value, 4, default = 0)) %>%
  ungroup()

rm( data_confirmed_sub,  data_recovered_sub, data_deceased_sub)


data_atDate <- function(inputDate) {data_evolution%>%
    filter(date == inputDate) %>%
    distinct() %>%
    pivot_wider(id_cols = c("id", "date", "latitude", "longitude", "Population"), names_from = var, values_from = value) 
}

data_latest <- data_atDate(data_evolution[which.max(data_evolution$date),]$date)

covid_global <- covid_nation[which(covid_nation$date == last(covid_nation$date)),]
covid_global_total <- as.numeric(list(
  confirm <- sum( covid_global$confirmed),
  recover <- sum( covid_global$recovered),
  death <- sum( covid_global$deaths),
  exist <- (confirm - recover -death)
))

covid_global2 <- covid_nation[which(covid_nation$date == last(covid_nation$date)-1),]
covid_global_total2 <-as.numeric(list(
  confirm <- sum( covid_global2$confirmed),
  recover <- sum( covid_global2$recovered),
  death <- sum( covid_global2$deaths),
  exist <- (confirm - recover -death)
))

top5_countries <- data_evolution %>%
  filter(var == "active", date == current_date) %>%
  group_by(id) %>%
  summarise(value = sum(value, na.rm = T)) %>%
  arrange(desc(value)) %>%
  top_n(5) %>%
  select(id) %>%
  pull()