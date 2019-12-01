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
           
                       tabPanel("Advanced Graphs and Models",
                                
                                tabsetPanel(
                                    
                                    tabPanel("Regime and GDP Simple Regression",
                                             
                                             h3("Regime vs. GDP for the US, South Korea, and Singapore from 1960-2018"),
                                             
                                    imageOutput("map3"),
                                    
                                    br(),
                                    
                                    br(),
                                    
                                    br(),
                                    
                                    br(),
                                    
                                        h2("Interpretation"),
                                    
                                            textOutput("texta")),
                                    
                                    
                                    tabPanel("Regime and GDP Per Capita",
                                             
                                             h3("GDP Per Capita vs Polity V2 Score for the Taiwan, Singapore, and South Korea from 1960-2018"),
                                             
                                    imageOutput("map4"),
                                    
                                    br(),
                                    
                                    br(),
                                    
                                    br(),
                                    
                                    br(),
                                    
                                        h2("Interpretation"),
                                    
                                            textOutput("textb")
                                    ))),
                                
                       tabPanel("About",
                                
                                h3("The Data"),
                              
                                    textOutput("about"),
                                
                                h5("Both data sets, as well as the user manuals, are available on the respective websites of both organizations", a("here", href="https://www.rug.nl/ggdc/productivity/pwt/"), "and", a("here", href="http://www.systemicpeace.org/inscrdata.html")),
                                
                                h3("About Me!"),
                                
                                    textOutput("me"), 
                                
                                h5("To contact me, my email is abrartrabulsi@college.harvard.edu and my linked in is", a("this", href = "linkedin.com/in/abrar-trabulsi"))
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
        
        "These graphs and analyses are based off of the Penn World Tables 9.1 as well as Polity IV's
        annual time series data set."
    })
    
    output$me <- renderText({
        
        "My name is Abrar Trabulsi and I'm a Harvard sophomore studying government and data science.
        I'm extremely passionate about domestic politics, international relations, and much more (that's unrelated to government entirely!).
        I hope to continue making, and releasing work related to data science during my undergraduate years and beyond."
    })
    
    output$texta <- renderText({
        
        "South Korea experienced consistent and explosive economic growth as a stringent autocracy for several decades before beginning the democratization process in 1988. 
        South Korea continued experiencing substantive economic growth except for in 1997, during the Asian financial crisis, which happened to occur
        during Korea's first civilian elected government in 3 decades. Singapore, which has consistently been a one-party autocracy for several decades,
        also benefitted from explosive economic growth between 1960 and 2018. The United States has experienced modest economic growth, and relatively
        consistent democratic governance. "
    })
    
    output$textb <- renderText({
        
        "This graph shows that for both South Korea and Taiwan, as GDP per capita increased, they became more democratic,
        and democratized a little after the per capita range theorized by Acemoglu and Robinson as the most dangerous for autocracies.
        Singapore had a per capita much higher than that of South Korea and Taiwan in 1960, a little under the $6,000 theorized by Acemoglu and Robinson
        as a point at which it would be incredibly difficult for autocracies to democratize. This suggests that for Singapore, the potential
        destabilization that comes with any regime change was too high of a cost to risk their already, relatively high GDP per capita, and the
        explocive economic growth the country had been and would continue to experience. South Korea and Taiwan on the other hand,
        initially had much lower GDP per capitas, and were well on the way to democratization before passing the threshold."
    })
}
# Run the application 
shinyApp(ui = ui, server = server)
