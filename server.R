function(input, output){
  
  output$plot1 <- renderPlot(
    {
      if(input$test=="Quentin")
      {
        i<-1
      }
      if(input$test=="Yohann")
      {
        i<-2
      }
      if(input$test=="Adel")
      {
        i<-3
      }
      if(input$button=="Distance Between targets")
      {
        j<-1
      }
      if(input$button=="Size of Targets")
      {
        j<-2
      }
      adelll <- iris[, i]
      yooo <- iris[, j]
      
      plot(adelll,yooo)
    }
  )
  
  
}