# server side function for creating DT object for Data Mapping tab
render_data_mapping_DT <- function(input_data, categories_data) {
  
  # Create an additional column for dropdowns
  data <- input_data %>%
    mutate(Category = NA) 
  
  # Define options for the dropdown list
  dropdown_options <- apply(
    categories_data, 1, function(row) paste(row, collapse = " - ")
  )
  
  # Add selectInput elements for the "Category" in each row
  data$Category <- sapply(seq_len(nrow(data)), function(i) {
    as.character(selectInput(
      inputId = paste0("data_mapping_cat_", i),
      label = NULL,
      choices = dropdown_options,
      selected = dropdown_options[1],
      width = "100%"
    ))
  })
  
  # Render the table
  table_with_dropdowns <- datatable(
    data,
    escape = FALSE, # Required to render HTML in table cells
    options = list(
      dom = 't', # Only show the table body without additional controls
      paging = FALSE, # Disable paging for simplicity
      ordering = FALSE # Disable ordering to keep rows stable
    ),
    selection = 'none'
  )
}