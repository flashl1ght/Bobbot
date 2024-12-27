library(shiny)
library(DT)
library(dplyr)

source("modules/data_mapping.R")

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
  
  # table for Data Mapping tab
  output$data_mapping_table <- renderDT({
    req(fin_data$input_tbl, categories_tbl(), input$if_input_mapped)
    render_data_mapping_DT(fin_data$input_tbl, categories_tbl())
  }, server = FALSE, rownames = FALSE, editable = FALSE, selection = 'none')
  
  # save selected categories
  observe({
    req(fin_data$input_tbl, categories_tbl(), input$data_mapping_cat_1,
        input$if_input_mapped)
    
    # collect selected categories dynamically
    selected_categories <- sapply(
      seq_len(nrow(fin_data$input_tbl)), function(i) {
        input[[paste0("data_mapping_cat_", i)]]
    })
    
    # save the selected categories in fin_data
    fin_data$mapped_data <- data.frame(
      fin_data$input_tbl, Categories = selected_values
    )
  })
}
