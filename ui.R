fluidPage(
  
  
  headerPanel("TunnelGoalFitts Test"),
  
  
  sidebarPanel(
    selectInput("test",
                "Test Type",
                choices = c("Fitts Test", "Tunnel Test", "Goal Test"), selected = "Fitts Test"),
    
    
    radioButtons("button",
                 "Compare Human Performance to..",
                 c("Distance Between targets", "Size of Targets"))
  ),
  
  
  mainPanel(
    plotlyOutput("plot1"),
   
     sliderInput("slider2", width = "100%", label = h3(""),
                min = 0,
                max = 9, value = c(0, 2))
  ),
)