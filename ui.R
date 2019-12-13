library(plotly)
fluidPage(
  
  
  headerPanel("TunnelGoalFitts Test"),
  
  
  sidebarPanel(
    selectInput("test",
                "Test Type",
                choices = GenerateSelectChoices(default = "All test", text = "", fieldName = "GameType")),
    
    
    radioButtons("button",
                 "Compare Human Performance to..",
                 c("Distance Between targets", "Size of Targets"))
  ),
  
  
  mainPanel(
    plotlyOutput("plot1"),
    
    sliderInput("slider2", width = "100%", label = '', post = 's',
                min = 0,
                max = 9, value = c(0, 2))
  ),
)