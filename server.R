library(plotly)
function(input, output, session) {
  
  
  
  output$range <- renderPrint({ input$slider2 })
  
  observeEvent(
    {input$test
      input$slider2
      input$button
      1
    }, {
      
      print(input$button)
      
      if (input$button == "Distance Between Targets") {
        tunneldata <- getData(gametype = "Tunnel", param = "TargetsDistanceInches", slidermin = input$slider2[[1]], slidermax = input$slider2[[2]])
        fittsdata <- getData(gametype = "Fitts", param = "TargetsDistanceInches", slidermin = input$slider2[[1]], slidermax = input$slider2[[2]])
        goaldata <- getData(gametype = "Goal", param = "TargetsDistanceInches", slidermin = input$slider2[[1]], slidermax = input$slider2[[2]])
      } else if (input$button == "Size of Targets") {
        tunneldata <- getData(gametype = "Tunnel", param = "TargetsSizeInches", slidermin = input$slider2[[1]], slidermax = input$slider2[[2]])
        fittsdata <- getData(gametype = "Fitts", param = "TargetsSizeInches", slidermin = input$slider2[[1]], slidermax = input$slider2[[2]])
        goaldata <- getData(gametype = "Goal", param = "TargetsSizeInches", slidermin = input$slider2[[1]], slidermax = input$slider2[[2]])
      } else {
        return()
      }
      
      # All GameType display in plotly
      if (input$test == -1)
      {
        output$plot1 <- renderPlotly(
          plot_ly(type = 'scatter',mode='markers')%>% 
            add_trace(x=tunneldata[['DeltaTime']], y=tunneldata[['TargetsDistanceInches']], mode='markers', marker=list(color='#0000FF')) %>%
            add_trace(x=fittsdata[['DeltaTime']], y=fittsdata[['TargetsDistanceInches']], mode='markers', marker=list(color='#228B22')) %>%
            add_trace(x=goaldata[['DeltaTime']], y=goaldata[['TargetsDistanceInches']], mode='markers', marker=list(color='#ff0000'))%>%
            layout(xaxis = list(title = "Human Performance (s)"), yaxis = list(title = "Distance (px)"))
        )
        return()
      }
      
      # Initialize color and data for simple plotly
      color = "#F00"
      simpledata = NULL
      # Check dropdown value
      # case "Tunnel"
      if (input$test == "Tunnel") {
        color = "#0000FF"
        simpledata = tunneldata
      }
      # case "Goal"
      else if (input$test == "Goal") {
        color = "#F00"
        simpledata = goaldata
      }
      # case "Fitts"
      else if (input$test == "Fitts") {
        color = "#228B22"
        simpledata = fittsdata
      }
      # default, no value correspond
      else {
        return()
      }
      
      
      
      print(input$slider2[[1]])
      # Simple GameType display in plotly
      output$plot1 <- renderPlotly(
        plot_ly(type = 'scatter',mode='markers')%>% 
          add_trace(x=simpledata[['DeltaTime']], y=simpledata[['TargetsDistanceInches']], mode='markers', marker=list(color=color)) %>%
          layout(xaxis = list(title = "Human Performance (s)"), yaxis = list(title = "Distance (px)"))
      )
    }
  )
  
  
}
