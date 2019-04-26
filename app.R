#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(magrittr)
x <- readRDS(file = file.path('data', 'appendix_6.RData'))
rownames(x) <- NULL
shinyApp(
  ui = fluidPage(
    fluidRow(
      column(12, DT::dataTableOutput('table')
      )
    )
  ),
  server = function(input, output) {
    output$table <- DT::renderDataTable(expr = {
      DT::datatable(data = x) %>%
        DT::formatRound(columns = c(4, 6, 7, 9, 10), digits = 1) %>%
        DT::formatRound(columns = 5, digits = 3)
    }, server = TRUE)
  }
)
