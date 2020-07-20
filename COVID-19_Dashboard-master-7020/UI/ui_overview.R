body_overview <- dashboardBody(
  tags$head(
    tags$style(type = "text/css", "#overview_map {height: 48vh !important;}"),
    tags$style(type = 'text/css', ".slider-animate-button { font-size: 20pt !important; }"),
    tags$style(type = 'text/css', ".slider-animate-container { text-align: left !important; }"),
    tags$style(type = "text/css", "@media (max-width: 991px) { .details { display: flex; flex-direction: column; } }"),
    tags$style(type = "text/css", "@media (max-width: 991px) { .details .map { order: 1; width: 100%; } }"),
    tags$style(type = "text/css", "@media (max-width: 991px) { .details .summary { order: 3; width: 100%; } }"),
    tags$style(type = "text/css", "@media (max-width: 991px) { .details .slider { order: 2; width: 100%; } }")
  ),
  fluidRow(
    fluidRow(
      uiOutput("box_keyFigures")
    ),
    fluidRow(
      class = "details",
      column(
        sliderInput(
          "timeSlider",
          label      = enc2utf8("选择时间"),
          min        = data_evolution[which.min(data_evolution$date),]$date,
          max        = data_evolution[which.max(data_evolution$date),]$date,
          value      = data_evolution[which.max(data_evolution$date),]$date,
          width      = "100%",
          timeFormat = "%Y-%m-%d",
          animate    = animationOptions(loop = TRUE)),
        class = "slider",width = 12),
      column(box(width = 12, leafletOutput("overview_map")),
             class = "map",width = 7, style = 'padding:0px;'),
      column(box(width = 12,uiOutput("summaryplot")),
             class = "plot",width = 5,style = 'padding:0px;')
    )
  )
)

page_overview <- dashboardPage(
  title   = "Overview",
  header  = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body    = body_overview
)