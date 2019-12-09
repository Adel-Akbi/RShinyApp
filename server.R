library(plotly)
function(input, output, session) {

  # # Combine the selected variables into a new data frame
  # selectedData <- reactive({
  #   iris[, c(input$test, radioButtons$button)]
  # })
  # 
  # clusters <- reactive({
  #   kmeans(selectedData(), radioButtons$button)
  # })
  # 
  # output$plot1 <- renderPlot({
  #   palette(c("#E41A1C", "#377EB8"))
  # 
  #   par(mar = c(5.1, 4.1, 0, 1))
  #   plot(selectedData(),
  #   col = clusters()$button,
  #   pch = 20, cex = 3)
  #   points(clusters()$centres, pch = 4, cex = 4, lwd = 4)
  # })
  pal <- c("red", "green")
  
  output$plot1 <- renderPlotly(plot_ly(economics, x = ~date, y = ~unemploy / pop, colors = pal))

}
