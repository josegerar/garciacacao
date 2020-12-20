#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(ggvis)

# Define UI for application that draws a histogram
shinyUI(dashboardPage(
  dashboardHeader(title = "Propiedades del cacao"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    h1("Cuadros estadisticos con ggplot"),
    fluidRow(
      box(width = 3,
        title = "Peso pepa cacao", status = "primary", solidHeader = TRUE,
        collapsible = TRUE,
        plotOutput("ggplotpepa")
      ),
      box(width = 3,
        title = "Longitud pepa cacao", status = "primary", solidHeader = TRUE,
        collapsible = TRUE,
        plotOutput("ggplotlongitud")
      ),
      box(width = 3,
        title = "Espesor pepa cacao", status = "primary", solidHeader = TRUE,
        collapsible = TRUE,
        plotOutput("ggplotespesor")
      ),
      box(width = 3,
        title = "Ancho pepa cacao", status = "primary", solidHeader = TRUE,
        collapsible = TRUE,
        plotOutput("ggplotancho")
      )
    ),
    h1("Cuadros estadisticos con ggviz"),
    fluidRow(
      box(width = 3,
          title = "Peso pepa cacao", status = "primary", solidHeader = TRUE,
          collapsible = TRUE,
          ggvisOutput("ggvizpepa"),
          ggvisOutput("ggvizpepabp")
      ),
      box(width = 3,
          title = "Longitud pepa cacao", status = "primary", solidHeader = TRUE,
          collapsible = TRUE,
          ggvisOutput("ggpvizlongitud"),
          ggvisOutput("ggpvizlongitudbp")
      ),
      box(width = 3,
          title = "Espesor pepa cacao", status = "primary", solidHeader = TRUE,
          collapsible = TRUE,
          ggvisOutput("ggvizespesor"),
          ggvisOutput("ggvizespesorbp")
      ),
      box(width = 3,
          title = "Ancho pepa cacao", status = "primary", solidHeader = TRUE,
          collapsible = TRUE,
          ggvisOutput("ggvizancho"),
          ggvisOutput("ggvizanchobp")
      )
    )
  )
))
