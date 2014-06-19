#
# Developing Data Products - Shiny Application
# (c) 2014 Pierre Gorissen
#

library(shiny)
library(datasets)


# Define server logic required 
shinyServer(function(input, output) {
  
  # Return the fitered dataset
  # Filter on selected Diets - input$showdiet
  # Filter on max time - input$time
  datasetInput <- reactive({
    ChickWeight[ChickWeight$Diet %in% input$showdiet & ChickWeight$Time < input$time,]
  })
  

  # Show the first "n" observations
  output$table <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
  # Output status message if needed
  output$message3 <- renderText({
    sub <- datasetInput()
    if (nrow(sub) == 0) {    
      "Please select at least 1 Diet!"
    }
  }) 
  
  # Output status message if needed
  output$message1 <- renderText({
    sub <- datasetInput()
    if (nrow(sub) == 0) {    
      "Please select at least 1 Diet!"
    }
  }) 
  
  # Output status message if needed
  output$message2 <- renderText({
    sub <- datasetInput()
    if (nrow(sub) == 0) {    
      "Please select at least 1 Diet!"
    }
  }) 
  
  # Output status message if needed
  output$message4 <- renderText({
    sub <- datasetInput()
    if (nrow(sub) == 0) {    
      "Please select at least 1 Diet!"
    }
  })   
  
  # function to calculate mean weight
  meanweight <- function(sub) {
      agg <- aggregate(sub$weight, list(diet = sub$Diet), mean)
      names(agg)[2] <- "Mean weight"
      names(agg)[1] <- "Diet"
      return(agg)
  }
  
  # Calculate mean weight per diet after x days
  output$meanweight <- renderTable({
    sub <- datasetInput()
    if (nrow(sub) > 0) {    
      meanweight(datasetInput())
    } else {
      message <- c("No Diets selected!")
      data.frame(message)
    }      
  })  
  
  
  # output title
  output$caption4 <- renderText({
    paste("Mean weight per diet based on ", input$time, " days", sep="")
  })    
  

  # Generate a plot of the data.
  showplot1 <- function(sub) {
    if (nrow(sub) > 0) {
      p <- qplot(Time, 
          weight, 
          data = sub,      
          colour = Diet,
          main = "Chick Weight per diet",
          xlab = "Time",
          ylab = "Chick Weight (gram)") 
      print(p)
    } else {
      # No diets selected!"
    }
    
  }

  # output the combined plot
  output$plot <- renderPlot({
    showplot1(datasetInput())	 
  })
  
  # Generate a plot of the data.
  showplot2 <- function(sub) {
    if (nrow(sub) > 0) {    
        p <- qplot(Time, 
               weight,
               data = sub,
               colour = Diet,
               facets = . ~ Diet,
               main = "Chick Weight per diet",
               xlab = "Time",
               ylab = "Chick Weight (gram)") 
    
        print(p)   
    } else {
      # No diets selected!"
    }    
    
  }

  # output the faceted plot
  output$plot2 <- renderPlot({
    showplot2(datasetInput())
  })
  

 
  
  
  
})
