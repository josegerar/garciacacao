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
library(ggplot2)
library(gridExtra)
library(ggvis)

con <- DBI::dbConnect(odbc::odbc(),
                      Driver   = "PostgreSQL Unicode",
                      Server   = "localhost",
                      Database = "cacao",
                      UID      = "postgres",
                      PWD      = "123456",
                      Port     = 5432)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    actor <- dbSendQuery(con, "SELECT id, peso_promedio,longitud,ancho, espesor FROM muestra")
    actorbd <- dbFetch(actor)
    output$ggplotpepa <- renderPlot({
        pl1 <- ggplot(actorbd) +  geom_histogram(binwidth = 0.4, aes(x = peso_promedio) , fill = "red")+ 
            geom_density(aes(x = peso_promedio)) +
            xlab("Peso") + ylab("Frecuencia") + 
            ggtitle("Distribucion  y densidad") + theme_minimal()
        pl2 <- ggplot(actorbd) + geom_boxplot(aes(y=peso_promedio))
        grid.arrange(pl1, pl2, nrow=2)
    })
    output$ggplotlongitud <- renderPlot({
        pl1 <- ggplot(actorbd) +  geom_histogram(binwidth = 1.2, aes(x = longitud) , fill = "red")+ 
            geom_density(aes(x = longitud)) +
            xlab("Longitud") + ylab("Frecuencia") + 
            ggtitle("Distribucion  y densidad") + theme_minimal()
        pl2 <- ggplot(actorbd) + geom_boxplot(aes(y=longitud))
        grid.arrange(pl1, pl2, nrow=2)
    })
    output$ggplotespesor <- renderPlot({
        pl1 <- ggplot(actorbd) +  geom_histogram(binwidth = 0.5, aes(x = espesor) , fill = "red")+ 
            geom_density(aes(x = espesor)) +
            xlab("Espesor") + ylab("Frecuencia") + 
            ggtitle("Distribucion  y densidad") + theme_minimal()
        pl2 <- ggplot(actorbd) + geom_boxplot(aes(y=espesor))
        grid.arrange(pl1, pl2, nrow=2)
    })
    output$ggplotancho <- renderPlot({
        pl1 <- ggplot(actorbd) +  geom_histogram(binwidth = 0.5, aes(x = ancho) , fill = "red")+ 
            geom_density(aes(x = ancho)) +
            xlab("Ancho") + ylab("Frecuencia") + 
            ggtitle("Distribucion  y densidad") + theme_minimal()
        pl2 <- ggplot(actorbd) + geom_boxplot(aes(y=ancho))
        grid.arrange(pl1, pl2, nrow=2)
    })
    actorbd %>% ggvis(~peso_promedio) %>% layer_histograms(width=0.4) %>% 
        layer_densities(fill = "red", stroke = "red") %>%
        set_options(width = "auto",resizable = TRUE, height = 300) %>%
        add_axis("x", tick_padding = 10, subdivide = 4, values = seq(1, 2, by = 0.2),
                 properties = axis_props(labels = list(fontSize = 8, angle = 90))) %>%
        bind_shiny("ggvizpepa")
    actorbd %>% ggvis(y=~peso_promedio, x=~1) %>% layer_boxplots() %>%
        set_options(width = "auto" , height = 300) %>%
        bind_shiny("ggvizpepabp")
    
    actorbd %>% ggvis(~longitud) %>% layer_histograms(width=1.2) %>% 
        layer_densities(fill = "red", stroke = "red") %>%
        set_options(width = "auto",resizable = TRUE, height = 300) %>%
        add_axis("x", tick_padding = 10, subdivide = 4, values = seq(21, 25, by = 1),
                 properties = axis_props(labels = list(fontSize = 8, angle = 90))) %>%
        bind_shiny("ggpvizlongitud")
    actorbd %>% ggvis(y=~longitud, x=~1) %>% layer_boxplots() %>%
        set_options(width = "auto" , height = 300) %>%
        bind_shiny("ggpvizlongitudbp")
    
    actorbd %>% ggvis(~espesor) %>% layer_histograms(width=0.5) %>% 
        layer_densities(fill = "red", stroke = "red") %>%
        set_options(width = "auto",resizable = TRUE, height = 300) %>%
        add_axis("x", tick_padding = 10, subdivide = 4, values = seq(8, 10, by = 0.5),
                 properties = axis_props(labels = list(fontSize = 8, angle = 90))) %>%
        bind_shiny("ggvizespesor")
    actorbd %>% ggvis(y=~espesor, x=~1) %>% layer_boxplots() %>%
        set_options(width = "auto" , height = 300) %>%
        bind_shiny("ggvizespesorbp")
    
    actorbd %>% ggvis(~ancho) %>% layer_histograms(width=0.5) %>% 
        layer_densities(fill = "red", stroke = "red") %>%
        set_options(width = "auto",resizable = TRUE, height = 300) %>%
        add_axis("x", tick_padding = 10, subdivide = 4, values = seq(12, 14.5, by = 0.5),
                 properties = axis_props(labels = list(fontSize = 8, angle = 90))) %>%
        bind_shiny("ggvizancho")
    actorbd %>% ggvis(y=~ancho, x=~1) %>% layer_boxplots() %>%
        set_options(width = "auto" , height = 300) %>%
        bind_shiny("ggvizanchobp")

})
