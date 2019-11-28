fluidPage(
  
  
  headerPanel("TunnelGoalFitts Test"),
  

    sidebarPanel(
      selectInput("test",
                  "Test Type", 
                  choices = c("Quentin", "Yohann", "Adel"), selected = "Adel"),
      
      
      radioButtons("button",
                   "Compare Human Performance to..",
                   c("Distance Between targets", "Size of Targets"))
    ),
  
    mainPanel(
    )
  
  
  
)

