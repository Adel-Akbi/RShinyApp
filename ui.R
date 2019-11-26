fluidPage(
  
  titlePanel("TunnelGoalFitts Test"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("test",
                  "Test Type", 
                  c("Adel", "Yohann", "Quentin"), selected = "Yohann")),
    
    radioButtons("button",
                 "Compare Human Performance to..",
                 c("Distance Between targets", "Size of Targets")),
    
    
  ),
  
  mainPanel()
)
