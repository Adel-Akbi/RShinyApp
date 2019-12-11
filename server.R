library(plotly)
function(input, output, session) {
  
  
  x0 <- rnorm(400, mean=2, sd=0.4)
  y0 <- rnorm(400, mean=2, sd=0.4)
  x1 <- rnorm(400, mean=3, sd=0.6)
  y1 <- rnorm(400, mean=6, sd=0.4)
  
  # shapes components
  cluster0 = list(
    type = 'circle',
    xref ='x', yref='y',
    x0=min(x0), y0=min(y0),
    x1=max(x0), y1=max(y0),
    opacity=0.25,
    line = list(color="#228B22 "),
    fillcolor="#228B22 ")
  
  cluster1 = list(
    type = 'circle',
    xref ='x', yref='y',
    x0=min(x1), y0=min(y1),
    x1=max(x1), y1=max(y1),
    opacity=0.25,
    line = list(color="#ff0000"),
    fillcolor="#ff0000")
  
  
 
  
  
  output$plot1 <- renderPlotly(plot_ly(type = 'scatter', mode='markers') %>%
                                 add_trace(x=x0, y=y0, mode='markers', marker=list(color='#228B22')) %>%
                                 add_trace(x=x1, y=y1, mode='markers', marker=list(color='#ff0000')) %>%
                                 layout(title = "Visualization Of People's Performance", showlegend = FALSE,
                                        xaxis = list(title = 'Human Performance (s)', margin( l = 100, unit = 'pt')), 
                                        yaxis = list(title = 'Distance (px)'))
                                        
                               
  )
  output$range <- renderPrint({ input$slider2 })
  
  
}
