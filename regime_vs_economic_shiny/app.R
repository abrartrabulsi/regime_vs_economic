# Loading all necessary libraries here. I will not be loading libraries like ggplot etc
# because I am creating plots in a spearate RMD file, reading them into my prep.R file,
# then inserting them into my shiny app server. I prefer this method over coding in my shiny app.

library(shiny)
library(shinythemes)

# Think of this like a tumblr theme, really good way of making things look good right off the bat
# without needing to code from the bottom up.


ui <- fluidPage(theme = shinytheme("flatly"),

# You can place the navbarPage WITHIN the fluidPage. they do not work in sileos. 
# Using them together works really well, better than either one independently.
# Also, HTML functions won't work within a navbarPage alone.

br(),

navbarPage("Outlining the Relationship between Regime and Economic Development",
                       tabPanel("Preliminary Graphs",
                                
                                tabsetPanel(
                                    
                                    tabPanel("GDP through the Years",
                                             
                                             h3("Real GDP of the US, Singapore, and South Korea from 1960-2018"),
                                
                                    imageOutput("map1")),
                                    
                                    tabPanel("GDP and Population",
                                             
                                             h3("Real GDP vs Population for the US, Singapore, and South Korea from 1960-2018"),
                                    
                                    imageOutput("map2")))),
           
                       tabPanel("Advances Graohs and Models",
                                
                                tabsetPanel(
                                    
                                    tabPanel("Regime and GDP Simple Regression",
                                             
                                             h3("Regime vs. GDP for the US, South Korea, and Singapore from 1960-2018"),
                                             
                                    imageOutput("map3")),
                                    
                                    tabPanel("Regime and GDP Per Capita",
                                             
                                             h3("GDP Per Capita vs Polity V2 Score for the Taiwan, Singapore, and South Korea from 1960-2018"),
                                             
                                    imageOutput("map4")))),
                                
                       tabPanel("About",
                              
                                    textOutput("about")
                                )
))

# Define server logic required to draw a histogram
server <- function(input, output, server) {
    output$map1 <- renderImage({
        
        
        list(src = "mymap1.gif",
             contentType = "image/gif",
             width = 600,
             height = 500)
        
        
    }, deleteFile = FALSE)
    
    output$map2 <- renderImage({
        
        
        list(src = "mymap2.gif",
             contentType = "image/gif",
             width = 600,
             height = 500)
        
        
    }, deleteFile = FALSE)
    
    output$map3 <- renderImage({
        
        
        list(src = "mymap3.png",
             contentType = "image",
             width = 600,
             height = 500)
        
        
    }, deleteFile = FALSE)
    
    output$map4 <- renderImage({
        
        
        list(src = "mymap4.png",
             contentType = "image",
             width = 600,
             height = 500)
        
        
    }, deleteFile = FALSE)
    
    output$about <- renderText({
        
        "Using data from the Penn World Tables as well as Polity V, I am looking at the relationship between regime type and economic development by evaluating data from the United States, Singapore, and South Korea
        I am looking at these particular cases because all three are hghly developed countries, and each displays economic growth from all aspects of the regome spectrum (democratic, autocratic, and autocratic turned democratic). 
        I hope to display this in my final project with further graphics that give more detailed information about this relationship."
    })
}
# Run the application 
shinyApp(ui = ui, server = server)
