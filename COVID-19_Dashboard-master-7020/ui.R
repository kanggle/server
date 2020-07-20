source("UI/ui_overview.R", local = TRUE)
source("UI/ui_plots.R", local = TRUE)
source("UI/ui_about.R", local = TRUE)
source("UI/ui_fullTable.R", local = TRUE)

ui <- fluidPage(theme = shinytheme("flatly"),
  title = enc2utf8("全球新冠疫情形势"),
  tags$head(tags$link(rel = "shortcut icon", type = "image/png", href = "search.png")),
  tags$style(type = "text/css", ".container-fluid {padding-left: 0px; padding-right: 0px !important;}"),
  tags$style(type = "text/css", ".navbar {margin-bottom: 0px;}"),
  tags$style(type = "text/css", ".content {padding: 0px;}"),
  tags$style(type = "text/css", ".row {margin-left: 0px; margin-right: 0px;}"),
  tags$style(HTML(".col-sm-12 { padding: 5px; margin-bottom: -15px; }")),
  tags$style(HTML(".col-sm-6 { padding: 5px; margin-bottom: -15px; }")),
  navbarPage(
    title = div(enc2utf8("全球新冠疫情形势")),
    inverse = TRUE, collapsible = TRUE, fluid= TRUE,
    tabPanel(enc2utf8("疫情速览"), icon = icon("dashboard"), page_overview, value = "page-overview"),
    tabPanel(enc2utf8("详细数据"), icon = icon("table"), page_fullTable, value = "page-fullTable"),
    tabPanel(enc2utf8("数据可视化"), icon = icon("chart-line"), page_plots, value = "page-plots"),
#   tabPanel(enc2utf8("数据预测"), icon = icon("alarm-exclamation"), page_predect, value = "page-predect"),
    tabPanel(enc2utf8("项目简介"), icon = icon("info-circle"), page_about, value = "page-about"),
    navbarMenu(enc2utf8("其他"), icon = icon("question-circle"),
               tabPanel(tags$a("", href = "url1", target = "_blank",list(icon("github"), enc2utf8("项目源代码")))),
               tabPanel(tags$a("", href = "url2", target = "_blank",list(icon("microsoft"), enc2utf8("项目源代码|镜像"))))
    ),
  tags$script(HTML("var header = $('.navbar > .container-fluid');
    header.append('<div style=\"float:right\"><a target=\"_blank\" href=\"https://www.youtube.com/watch?v=cNcLxXbFEEA\"><img src=\"Matana.png\" alt=\"alt\" style=\"float:right;width:33px;padding-top:10px;margin-top:-50px;margin-right:10px\"> </a></div>');
    console.log(header)")
    )
  )
)