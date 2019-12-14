# Loading all necessary libraries here. I will not be loading libraries like ggplot etc
# because I am creating plots in a spearate RMD file, reading them into my prep.R file,
# then inserting them into my shiny app server. I prefer this method over coding in my shiny app.
# I only coded in my shiny app for the interactive plot (Plotly) because it is necessary.
# I tried other plots out with Plotly and there were some issues with spacing of
# axis labels, too.

library(shiny)
library(shinythemes)
library(plotly)
library(readr)
library(gganimate)
library(vembedr)
library(htmltools)

# Think of this like a tumblr theme, really good way of making things look good right off the bat
# without needing to code from the bottom up.

data <- read_rds("data.rds")

ui <- fluidPage(theme = shinytheme("flatly"),

# You can place the navbarPage WITHIN the fluidPage. they do not work in sileos. 
# Using them together works really well, better than either one independently.
# Also, HTML functions won't work within a navbarPage alone.

br(),

# use different HTML commands like br() for stylistic reasons

navbarPage("Outlining the Relationship between Regime and Economic Development",
           
           
                       tabPanel("Preliminary Graphs",
                                
                               # tabsetPanel is how you make tabs within your tabs. This is extremely useful!
                                
                                tabsetPanel(
                                    
                                    tabPanel("GDP through the Years",
                                             
                                             h3("Real GDP for all Countries from 1960-2018"),
                                             
                                        # sidebars are cool but also extremely fickle, it's important to pay very close attention to,
                                        # and to keep track of, paraentheses 
                                        
                                        sidebarPanel(
                                            
                                            # you must make the beginning variable the same as the variable you "filter" by in the Plotly code
                                            # the levels aspect will grab the corresponding data for the X and Y variables for all the values
                                            # under the categorical variable you have just requested from the data frame
                                            
                                            selectInput("countrygdp", "Country:", levels(data$country))),
                                                        
                                    mainPanel(
                                        
                                        plotlyOutput("GDPPlotly")
                                    )),
                                    
                                    tabPanel("Per Capita GDP Through the Years",
                                             
                                             h3("GDP Per Capita for all Countries from 1960-2018"),
                                             
                                    sidebarPanel(
                                        
                                        selectInput("countrypercap", "Country:", levels(data$country))),
                                    
                                    mainPanel(
                                        
                                        plotlyOutput("PerCapPlotly")
                                    )))),
           
                       tabPanel("Asian Tigers Advanced Graphs",
                                
                                tabsetPanel(
                                    
                                    tabPanel("Regime and GDP Simple Regression",
                                             
                                             h3("Regime vs. GDP for the Taiwan, South Korea, and Singapore from 1960-2018"),
                                             
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
                                    
                                        h2("Useful Information for Interpretting the Plot"),
                                    
                                            textOutput("useful"),
                                    
                                        h2("Interpretation"),
                                    
                                            textOutput("textb")
                                    ))),
           
           tabPanel("Aggregate Advanced Graohs",
                    
                    tabsetPanel(
                        
                        tabPanel("Aggregate GDP and Regime Fixed Effects Regression",
                                 
                                 h3("Regime vs. GDP, Fixing for both Year and Country"),
                                 
                                 imageOutput("map5"),
                                 
                                 br(),
                                 
                                 br(),
                                 
                                 br(),
                                 
                                 br(),
                                 
                                 h2("Interpretation"),
                                 
                                 textOutput("textc")),
                        
                        
                        tabPanel("Aggregate GDP Per Capita and Regime Fixed Effects Regression",
                                 
                                 h3("Regime vs. GDP Per Capita, Fixing for both Year and Country"),
                                 
                                 imageOutput("map6"),
                                 
                                 br(),
                                 
                                 br(),
                                 
                                 br(),
                                 
                                 br(),
                                 
                                 h2("Interpretation"),
                                 
                                 textOutput("textd")
                                 
                        ))),
                                
                       tabPanel("About",
                                
                                h3("The Data"),
                              
                                    textOutput("about"),
                                
                                # a() is how you insert a hyperlink into shiny HTML commands, also really useful!
                                
                                h5("Both data sets, as well as the user manuals, are available on the respective websites of both organizations", a("here", href="https://www.rug.nl/ggdc/productivity/pwt/"), "and", a("here", href="http://www.systemicpeace.org/inscrdata.html")),
                                h5("You can find all the code for this project at", a("this", href = "https://github.com/abrartrabulsi/regime_vs_economic"), "GitHub Repo. My GitHub profile is here too!"),
                                
                                h3("About Me!"),
                                
                                    textOutput("me"), 
                                
                                h5("To contact me, my email is abrartrabulsi@college.harvard.edu and my linked in is", a("this", href = "https://linkedin.com/in/abrar-trabulsi")),
                                
                                h3("Video Walk Through of my Project"),
                                
                                # I tried embed_youtube but for some reason that wouldn't work, this did though
                                
                                embed_url("https://www.youtube.com/watch?v=-y5OKwQoWSw&t=5s"),
                                
                                h3("Interesting Musings About the Information Shown"),
                                
                                textOutput("interesting"),
                                
                                # note that spaces between paragraphs can't be done in textOutputs (or at least I haven't figured it out myself)
                                # so a good way to get around this is to use a smaller HTML header level. They put space automatically between them
                                
                                h3("References"),
                                h5("Wade, R. (1990). Governing the Market. Princeton University Press. Retrieved December 12, 
                                2019."),
                                h5("A., & Limongi, F. (1997). Modernization: Theories and Facts. World Politics,49(02), 155-183. 
                                doi:10.1353/wp.1997.00043.0019")
                                
                                )
))

# Define server logic required to draw a histogram
server <- function(input, output, server) {
    
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
    
    output$map5 <- renderImage({
        
        
        list(src = "mymap5.png",
             contentType = "image",
             width = 600,
             height = 500)
        
        
    }, deleteFile = FALSE)
    
    output$map6 <- renderImage({
        
        
        list(src = "mymap6.png",
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
        during Korea's first civilian elected government in 3 decades. Whether this factors into the occurence of the financial crisis is unclear, but it is possible since there is 
        documented evidence of governmental events affecting economic performance. Taiwan's economic performance relative to regime type is also consistent with that of South Korea, except for the 
        fact that Taiwan did not seem as affected by the finalcial crisis as South Korea was. Singapore, which has consistently been a one-party autocracy for several decades,
        also benefitted from explosive economic growth between 1960 and 2018. For South Korea, Singapore, and Taiwan, it seems as though their vast economic development did have
        something to do with the fact that they are/were autocracies, especially Singapore, which has maintained the same Polity score for
        decades. Literature will support this, with experts citing certain features unique to autocracies such as state-led economic initiatives attributing to 
        their growth. See the 'About' page for more."
    })
    
    output$textb <- renderText({
        
        "This graph shows that for both South Korea and Taiwan, as GDP per capita increased, they became more democratic,
        and democratized a little after the per capita range theorized by Przeworski and Limongi as the most dangerous for autocracies.
        Singapore had a per capita much higher than that of South Korea and Taiwan in 1960, a little under the $6,000 theorized by Przeworski and Limongi
        as a point at which it would be incredibly difficult for autocracies to democratize. This suggests that for Singapore, the potential
        destabilization that comes with any regime change was too high of a cost to risk their already, relatively high GDP per capita, and the
        explocive economic growth the country had been and would continue to experience. South Korea and Taiwan on the other hand,
        initially had much lower GDP per capitas, and were well on the way to democratization before surpassing the threshold, so there was less
        to potentially lose through regime change."
    })
    
    output$textc <- renderText({
        
        "This plot is a fixed effects graph mapping the overall relationship between regime type and GDP controlling for year
        and country. This is so particular fiscal anomalies, such as the 1997 Asian financial crisis, as well as cultural differences 
        in a particular country do not affect the overall mapping of a relationship. While a linear model is not the most useful for this data dur to the
        adjusted R^2 showing that the model is not very good, the plot itself is fascinating. As shown, while there
        are more democratic countries with high GDPs, there is also a fairly high amount of autocratic countries with
        large GDPs, and interestingly enough, they all have the same Polity score. This could suggest that regime type has very little to do
        causally with a country's GDP. Furthermore, if there's anything the small adjusted R^2 can say, it's that there is little to no linear relationship
        between these two variables. To test signifigance in the difference in sheer quantity between high GDP grossing democratic and
        autocratic countries a hypothesis test could be conducted and evaluated at an alpha of .05."
    })
    
    output$textd <- renderText({
        
        "This plot is also a fixed effects graph like the first except that it is mapping the relationship between GDP per capita
        and regime. Also much like the first, the adjusted R^2 is very low meaning that a linear model is not the best fit for these data. 
        In this plot, we can see that a higher quantity of autocratic countries have high GDP per capitas than democratic countries, however, with seemingly 
        high variability within each Polity score. This is interesting, because most wouldn't automatically think of
        autocratic countries as more wealthy per capita than their democratic counterparts on first thought. Especially those of us
        raised and educated in the United States, the narrative of prosperity coinciding closely with democracy is one that
        comes automatically when asked. However, this plot seems to place doubt in that theory. To better understand if there
        is a causal effect of some sort, a causal experiment would have to be conducted somehow, most likely through
        simulated data. Or more simply as in the first plot, a hypothesis test for significant difference can be conducted
        to see if the difference in sheer quantity of high grossing autocratic countries per capita is significant enough for
        there to possibly be a casual relationship"
    })
    
    output$GDPPlotly <- renderPlotly({
        
        ggplotly(data %>%
                     filter(country == input$countrygdp) %>%
                     
                     # to get the plot to take inputs form a variable and spit out UNIQUE outputs, you MUST
                     # filter by user input
                     
                     filter(year > 1960) %>%
                     ggplot(aes(x = year, y = rgdpna)) + 
                     geom_line() +
                     scale_y_log10() +
                     labs(title = "", x = "Year", y = "Real GDP")
                 
                 ) 
    })
    
    output$useful <- renderText({
        
        "The two black lines are the area at which autocracies are most vulnerable to democratization ($1000 - $4000 GDP Per Capita).
        The blue line is the parameter at which autocracies are deemed safe from the forces of democratization ($6000 GDP Per Capita).
        And Lastly, the line at 0 Polity V2 is the differentiating line between an autocracy and dmeocracy. The GDP Per Capita parameters are 
        per those theorized, and extensively discussed by Przeworski and Limongi."
    })
    
    # I wrote this in my RMD too, but the reason why i don't have a key for these is because I couldn't make one
    # show up despite having the right code for one which you'll be able to see once you check my RMD code for this plot.
    
    output$interesting <- renderText({
        
        "I'm primarily going to talk about the inspiration for this project, which is maininly the story of the East Asian Tigers.
        These are countries which had just come our of colonialization and brutal war, and were thwarted onto the world stage as nation states during a time
        when the Cold War was just beginning. They were able to transform themselves from some of the poorest countries in the world,
        to same of the wealthiest in the span of 3 decades. This was absoltely unprescedented, and went against everything political scientists and
        economists had thought was true for so long. When I learned about these coutries in a GOV 20, a comparative government class I took my freshman year,
        I was fascinated. What it seemed like to me was that these countries were able to develop so rapidly in part because they were autocracies,
        because their regimes could implement aggressive state led economic policy like choosing which industries would be fostered and catered to
        with tax incentives, regulating foreign investment so that industries in their infamcy wouldn't be overtaken by their much more powerful foreign 
        counterparts and more. This led to many questions about the relationship between regime and economic development. This project does not set out to
        definitely answer these questions, because after all that would take much more extensive scholarship, experimentation, and time to do so, but rather
        visually outline current data about what this relationship could look like. In the long run, I am hoping to bring this together with more
        qualitative information and analysis, because after all, it's only when sileoed neither quantitative or qualitative analysis
        is sufficient to outline most phenomenon."
    })
    
    output$PerCapPlotly <- renderPlotly({
        
        ggplotly(data %>%
            filter(country == input$countrypercap) %>%
            
            # when you're making new plotlys', the input variable name in your filter
            # as well as the ui must be different from those of other plotlys'
                
            filter(year > 1960) %>%
            ggplot(aes(x = year, y = gdpercap)) + 
            geom_line() +
            scale_y_log10() +
            labs(title = "", x = "Year", y = "GDP Per Cap")
            
        )
    })
}
# Run the application 
shinyApp(ui = ui, server = server)
