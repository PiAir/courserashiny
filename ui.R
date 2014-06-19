#
# Developing Data Products - Shiny Application
# (c) 2014 Pierre Gorissen
#

library(ggplot2)
library(shiny)
library(datasets)
# load the build in R dataset for chick weights

data(ChickWeight)

# Define UI for application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Developing Data Products - Shiny Application"),
  
  # Sidebar with controls to select which diets to shows in the plot
  # and max Time
  sidebarPanel(
    h3("Instructions"),
    p("Chicks can be fed 4 different diets during a period of max. 21 days.
       You can select the diets below.
       In the panels you can see the weight distribution of the chicks.
       You can see the data in a combined plot, a faceted plot (one for each selected diet),
       you can see the raw data (select how many rows you want to see), and the average weight
       for each selected diet.
       You can set the Max. time to show if you want other time frames than the full 21 days."),
    checkboxGroupInput("showdiet", "Show diet(s)",
                       c("Diet 1" = "1",
                         "Diet 2" = "2",
                         "Diet 3" = "3",
                         "Diet 4" = "4"),
                        c("1", "2", "3", "4")),
    numericInput("time", "Max. time to show:", max(ChickWeight$Time)),
    p("Note: the max. time setting restricts all panels, so both plots, the table and the mean weight.")
    
  ),
  
  # Show a tabpanel to select: 
  # a plot of all selected diets (default plot)
  # a faceted plot of the selected diets
  # an HTML table with the data
  # an HTML table with the mean weight per diet
  mainPanel(
    tabsetPanel(
      tabPanel("Combined Plot", 
               h4(textOutput("message1")),
               plotOutput("plot") 
               ), 
      tabPanel("Faceted Plot", 
               h4(textOutput("message2")),
               plotOutput("plot2")
               ), 
      tabPanel("Table", 
               h4(textOutput("message3")),
               numericInput("obs", "Number of observations to show:", 10), 
               tableOutput("table")
               ),
      tabPanel("Mean Weight", 
               h4(textOutput("message4")),
               h3(textOutput("caption4")), 
               tableOutput("meanweight") 
               )
    )

  )
))
