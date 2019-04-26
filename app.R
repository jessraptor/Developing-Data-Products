library(shiny)
library(ggplot2)
library(dplyr)
library(shinyWidgets)
bcl<-read.csv("bcl-data.csv", stringsAsFactors = FALSE)

ui<-fluidPage(
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

server<-function(input,output){
        output$countryOutput<-renderUI({
                selectInput("countryInput","Country",
                            sort(unique(bcl$Country)),
                            selected="FRANCE")
        })
        
        filtered<-reactive({
                if(is.null(input$countryInput)){
                        return(NULL)
                }
                
                bcl %>%
                        filter(Price>=input$priceInput[1],
                               Price<=input$priceInput[2],
                               Type==input$typeInput,
                               Country==input$countryInput
                        )
        })
               
 output$coolplot<-renderPlot({
         if(is.null(filtered())){
                 return()
         }
         ggplot(filtered(),aes(x=Alcohol_Content,color=Type))+
                 geom_histogram(fill='blue', alpha=0.6)
 })       
        

 output$results<-renderTable({
         filtered()
 })
         
}

shinyApp(ui=ui,server=server)
##no more R code after this!
