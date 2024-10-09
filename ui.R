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
      )
    )
  )
)
