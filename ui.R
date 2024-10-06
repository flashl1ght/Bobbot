library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  skin = "black",
  dashboardHeader(
    title = "Hobbot"
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "tab_home", icon = icon("home"))
    )
  ),
  dashboardBody()
)