library(shiny)
library(DT)

server <- function(input, output, session) {
  
  # config data
  categories_tbl <- reactiveVal()
  
  # populate reactive value with input table
  observeEvent(input$categories_import, {
    file <- input$categories_import
    ext <- tools::file_ext(file$datapath)
    
    req(file)
    validate(need(ext == "csv", "Please upload a csv file"))
    
    input_tbl <- read.csv(file$datapath, header = TRUE)
    categories_tbl(input_tbl)
  })
  
  # table for Config tab
  output$categories_table <- renderDT({
    categories_tbl()
  }, server = FALSE, rownames = FALSE, editable = FALSE, selection = 'none')
  
  # financial data
  fin_data <- reactiveValues()
  
  # populate reactive value with input table
  observeEvent(input$data_finace_import, {
    file <- input$data_finace_import
    ext <- tools::file_ext(file$datapath)
    
    req(file)
    validate(need(ext == "csv", "Please upload a csv file"))
    
    fin_data$input_tbl <- read.csv(file$datapath, header = TRUE)
  })
  
  # table for Data input tab
  output$data_finance_table <- renderDT({
    fin_data$input_tbl
  }, server = FALSE, rownames = FALSE, editable = FALSE, selection = 'none')
  
}
