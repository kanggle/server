body_about <- dashboardBody(
  dashboardBody(
    fluidRow(
      boxPlus(
        sidebar_background = "red",
        title = div("注意", style = "padding-left: 500px", class = "h1"), 
        closable = FALSE, 
        status = "warning", 
        width = 12,
        solidHeader = FALSE, 
        collapsible = FALSE,
        p(div("此项目所有数据来自于github第三方公开数据，不对数据和分析的可靠性做任何保证", 
              style = "padding-left: 100px", class = "h3"))
      ),
      boxPlus(width = 12,
              sidebar_background = "blue",
              column(width = 12,
                     title = "关于项目",
                     column(
                       h2("关于项目"),
                       h3("数据来源"),
                       "1.部分项目数据主要来源于南方医科大学的",
                       a("余光创教授", href="http://portal.smu.edu.cn/jcyxy/info/1084/2203.htm") ,
                       "发布在github上的获取疫情实时数据的R包。" ,
                       a("nCov2019", href="https://github.com/GuangchuangYu/nCov2019"),
                       "实时数据来自腾讯， 每天更新。历史数据来源：丁香园，国家卫健委，和 gitHub 数据每天更新。",
                       tags$br(),
                       "2.另外部分项目数据主要来源于CSSE at Johns Hopkins University发布在github上的获取全球疫情实时数据的R包",
                       a("COVID-19", href="https://github.com/CSSEGISandData/COVID-19"),
                       "。",
                       tags$br(),
                       h3("项目构建"),
                       "1.项目构思于2020年5月，并于2020年6月开始筹备，2020年7月15日上线，一直在不断维护。",
                       tags$br(),
                       "2.硬件配置：最初项目托管在shiny提供的免费平台",
                       a("阿里云高校学生计划", href="https://www.shinyapps.io/"),
                       "但是其服务器在境外，访问极慢，目前项目托管在中国阿里云ECS云服务器，并通过阿里云的",
                       a("阿里云高校学生计划", href="https://developer.aliyun.com/adc/student/"),
                       "进行续用服务器（俗称:薅羊毛），服务器性能受限，访问仍然较慢。",
                       tags$br(),
                       "3.软件配置：",
                       tags$br(),
                       "3.1.此域名在有效期（2020年6月27日--2021年6月27日）內为个人所有，不属于组织机构。",
                       tags$br(),
                       "3.2.软件代码部分参考了以下github开源项目，网站用途仅限于学习交流，禁止任何商业用途：",
                       tags$br(),
                       a("wuhan","https://github.com/gexijin/wuhan") , 
                       'Coronavirus COVID-19 statistics and forecast',
                       tags$br(),
                       a("COVID-19 Re","https://github.com/covid-19-Re") , 
                       'R Shiny app to calculate and display Re estimates',
                       tags$br(),
                       a("The Coronavirus Dashboard","https://github.com/RamiKrispin/coronavirus_dashboard") , 
                       'This Coronavirus dashboard provides an overview of the 2019 Novel Coronavirus COVID-19 
                        (2019-nCoV) epidemic. This dashboard is built with R using the Rmakrdown framework and can 
                        easily reproduce by others.',
                       tags$br(),
                       a("Coronavirus 10-day forecast","https://github.com/benflips/nCovForecast") , 
                       'The app is under continual development. Contributions and suggestions are welcome. 
                        If you have data that you would like to see represented here, please get in contact.',
                       tags$br(),
                       h3(" "),
                       width = 12))),
      boxPlus(width = 12,
              sidebar_background = "green",
              column(
                width = 12,
                h3("联系方式"),
                "如果此项目侵犯了您的合法权益，亦或是您对于此项目有任何的疑问及改进措施",
                tags$br(),
                "欢迎您通过以下方式联系我：",
                tags$br(),
                "邮箱：fjmulkg@outlook.com"
                
              )
      ))
  )
)


page_about <- dashboardPage(
  title = "About",
  header = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body = body_about
)
