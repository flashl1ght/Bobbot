library(shiny)
library(DT)

server <- function(input, output, session) {
  
  # table for Config tab
  output$categories_table <- renderDT({
    file <- input$categories_import
    ext <- tools::file_ext(file$datapath)
    
    req(file)
    validate(need(ext == "csv", "Please upload a csv file"))
    
    read.csv(file$datapath, header = TRUE)
  }, server = FALSE, rownames = FALSE, editable = FALSE, selection = 'none')
  
  # table for Data input tab
  output$data_finance_table <- renderDT({
    file <- input$data_finace_import
    ext <- tools::file_ext(file$datapath)
    
    req(file)
    validate(need(ext == "csv", "Please upload a csv file"))
    
    read.csv(file$datapath, header = TRUE)
  }, server = FALSE, rownames = FALSE, editable = FALSE, selection = 'none')
}
