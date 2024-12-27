library(shiny)
library(shinydashboard)
library(DT)

ui <- dashboardPage(
  skin = "black",
  dashboardHeader(
    title = "Hobbot"
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem(
        "Home", tabName = "tab_home", icon = icon("home")
      ),
      menuItem(
        "Config", tabName = "tab_config", icon = icon("gear")
      ),
      menuItem(
        "Data input", tabName = "tab_data_input", icon = icon("table")
      ),
      menuItem(
        "Data mapping", tabName = "tab_data_mapping", icon = icon("table-list")
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "tab_config",
        fluidRow(
          column(
            width = 12,
            h2("Categories"),
            hr(),
            fileInput(
              "categories_import", "Import categories", accept = c(".csv")
            ),
            DTOutput("categories_table")
          )
        )
      ),
      tabItem(
        tabName = "tab_data_input",
        fluidRow(
          column(
            width = 12,
            h2("Data input"),
            hr(),
            fileInput(
              "data_finace_import",
              "Import financial statement",
              accept = c(".csv")
            ),
            DTOutput("data_finance_table")
          )
        )
      ),
      tabItem(
        tabName = "tab_data_mapping",
        fluidRow(
          column(
            width = 12,
            h2("Data mapping"),
            hr(),
            DTOutput("data_mapping_table")
          )
        )
      )
      
    )
  )
)
