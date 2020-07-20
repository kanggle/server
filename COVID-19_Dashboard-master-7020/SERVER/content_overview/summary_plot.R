  data_summary_plot <- covid_china$global %>%
    select(name, confirm, dead, heal)
  data_summary_plot$active <- data_summary_plot$confirm - data_summary_plot$dead - data_summary_plot$heal
  colnames(data_summary_plot) <- c('id', 'confirmed', 'deceased', 'recovered', 'active')
  
getSummaryplot <- function(value){
  data_summary_plot <- data_summary_plot %>%
    select("id", value)%>%
    arrange(value) %>%
    top_n(10)
  options(scipen=200)
  plot <- ggplot(data = data_summary_plot, aes(x = id, y = data_summary_plot[,2] )) +  
    geom_bar(width = 0.5, stat="identity",position = position_dodge(width = 0.9), fill=hcl.colors(10, "Set 2")) + 
    theme(axis.title.y = element_blank(),
          axis.title.x = element_blank()) + 
    geom_text(aes(label = data_summary_plot[,2], hjust = 0.8), show.legend = TRUE)+
    scale_fill_brewer(palette = "Set1")+
    ylim(-50000, max(data_summary_plot[,2])*1.2)+
    coord_flip()
  return(plot)
}


output$summaryplot <- renderUI({
  tabBox(
    tabPanel(enc2utf8("累计确诊"),
      div(
        plotlyOutput("summaryplot_confirmed"),
        style = "margin-top: -10px")
    ),
    tabPanel(enc2utf8("累计死亡"),
      div(
        plotlyOutput("summaryplot_deaths"),
        style = "margin-top: -10px"
      )
    ),
    tabPanel(enc2utf8("累计治愈"),
             div(
               plotlyOutput("summaryplot_recovered"),
               style = "margin-top: -10px"
             )
    ),
    tabPanel(enc2utf8("现存（估计）"),
             div(
               plotlyOutput("summaryplot_active"),
               style = "margin-top: -10px"
             )
    ),
    width = 12
  )
})

output$summaryplot_confirmed <- renderPlotly(getSummaryplot('confirmed'))
output$summaryplot_deaths   <- renderPlotly(getSummaryplot('deceased'))
output$summaryplot_recovered <- renderPlotly(getSummaryplot('recovered'))
output$summaryplot_active  <- renderPlotly(getSummaryplot('active'))