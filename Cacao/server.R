#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DBI)
library(odbc)
library(DT)

con <- DBI::dbConnect(odbc::odbc(),
                      Driver   = "PostgreSQL Unicode",
                      Server   = "localhost",
                      Database = "cacao",
                      UID      = "postgres",
                      PWD      = "123456",
                      Port     = 5432)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    actor <- dbSendQuery(con, "SELECT * FROM actorsector")
    actorbd <- dbFetch(actor)
    
    # Filter data based on selections
    output$table <- DT::renderDataTable(DT::datatable({
        data <- actorbd
        
        data
    }))

})
