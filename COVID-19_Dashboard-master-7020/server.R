server <- function(input, output) {
  sourceDirectory("SERVER", recursive = TRUE)

  showNotification(enc2utf8("感谢您对新冠疫情的关注！"),
    duration = 10, type = "warning")

  # Trigger once an hour
  dataLoadingTrigger <- reactiveTimer(3600000)

  observeEvent(dataLoadingTrigger, {
    updateData()
  })

  observe({
    data <- data_atDate(input$timeSlider)
  })
}