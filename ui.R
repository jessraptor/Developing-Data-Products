library(shiny)
library(ggplot2)
library(dplyr)
library(shinyWidgets)
bcl<-read.csv("bcl-data.csv", stringsAsFactors = FALSE)

ui<-fluidPage(
        tags$h2("Change shiny app background"),
        setBackgroundColor("powderblue"),
        titlePanel("BC Liquor Store Prices"),
        sidebarLayout(
                sidebarPanel(
                        sliderInput("priceInput","Price",0,200,c(5,35),pre="$"),
                        radioButtons("typeInput","Product Type",
                                     choices=c("BEER","REFRESHMENT","SPIRITS","WINE"),
                                     selected="WINE"),
                        uiOutput("countryOutput")
                ),
                mainPanel(
                        plotOutput("coolplot"),
                        br(),br(),
                        tableOutput("results")
                )
        )
)