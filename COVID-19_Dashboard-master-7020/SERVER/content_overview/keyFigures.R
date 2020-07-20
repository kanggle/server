key_figures <- reactive({
  # data           <- sumData(input$timeSlider)
  # data_yesterday <- sumData(input$timeSlider - 1)

  data_new <- list(
    new_confirmed = (sum(covid_global$confirmed) - sum(covid_global2$confirmed)) / sum(covid_global2$confirmed) * 100,
    new_recovered = (sum(covid_global$recovered) - sum(covid_global2$recovered)) / sum(covid_global2$recovered) * 100,
    new_deceased  = (sum(covid_global$deaths) - sum(covid_global2$deaths)) / sum(covid_global2$deaths) * 100,
    new_active    = (sum(covid_global$confirmed - covid_global$recovered - covid_global$deaths) 
                     - sum(covid_global2$confirmed - covid_global2$recovered - covid_global2$deaths)) / sum(covid_global2$confirmed - covid_global2$recovered - covid_global2$deaths) * 100,
    new_countries = nrow(covid_global) - nrow(covid_global2)
  )

  keyFigures <- list(
    "confirmed" = HTML(paste(format(sum(covid_global$confirmed), big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_confirmed))),
    "recovered" = HTML(paste(format(sum(covid_global$recovered), big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_recovered))),
    "deceased"  = HTML(paste(format(sum(covid_global$deaths), big.mark = " "), sprintf("<h4>(%+.1f %%)</h4>", data_new$new_deceased))),
    "active"  = HTML(paste(format(sum(covid_global$confirmed - covid_global$recovered - covid_global$deaths), big.mark = " "), 
                           sprintf("<h4>(%+.1f %%)</h4>", data_new$new_active))),
    "countries" = HTML(paste(format(nrow(covid_global), big.mark = " "), sprintf("<h4>(%+d)</h4>", data_new$new_countries)))
  )
  return(keyFigures)
})

output$valueBox_confirmed <- renderValueBox({
  valueBox(
    key_figures()$confirmed,
    subtitle = enc2utf8("累计确诊"),
    icon     = icon("prescription-bottle-alt"),
    color    = "red"
  )
})


output$valueBox_recovered <- renderValueBox({
  valueBox(
    key_figures()$recovered,
    subtitle = enc2utf8("累计治愈"),
    icon     = icon("hand-holding-heart"),
    color    = "green"
  )
})

output$valueBox_deceased <- renderValueBox({
  valueBox(
    key_figures()$deceased,
    subtitle = enc2utf8("累计死亡"),
    icon     = icon("tombstone"),
    color    = "teal"
  )
})

output$valueBox_active <- renderValueBox({
  valueBox(
    key_figures()$active,
    subtitle = enc2utf8("现存（估计）"),
    icon     = icon("hospital-user"),
    color    = "blue"
  )
})

output$valueBox_countries <- renderValueBox({
  valueBox(
    key_figures()$countries,
    subtitle = enc2utf8("波及国家地区"),
    icon     = icon("flag"),
    color    = "orange"
  )
})

output$box_keyFigures <- renderUI(box(
  title = paste0(enc2utf8("数据同步至："), strftime(input$timeSlider, format = "%Y-%m-%d")),
  fluidRow(
    column(
      valueBoxOutput("valueBox_confirmed", width = 3),
      valueBoxOutput("valueBox_recovered", width = 2),
      valueBoxOutput("valueBox_deceased", width = 2),
      valueBoxOutput("valueBox_active", width = 3),
      valueBoxOutput("valueBox_countries", width = 2),
      width = 12,
      style = "margin-left: -20px"
    )
  ),
  div(enc2utf8("数据最后下载时间："), strftime(changed_date, format = "%Y-%m-%d - %R %Z")),
  width = 12
))