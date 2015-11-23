library(shiny)

# Define UI for our height prediction application
shinyUI(fluidPage(
  
  #   Application title
  titlePanel("Predict the height of your child, Based on Galton Data"),
  
  # Sidebar with a couple of numeric inputs and a radio button
  #pageWithSidebar( 
  sidebarLayout(
    sidebarPanel(
      helpText("Please use the sliders to set heights for the mom and dad, and select child's gender. The results is a prediction of the child's height."),
      sliderInput(inputId = "dad",
                   label = "Dad's height:",
                   value = 69, # default dad height
                   min = 58,
                   max = 78,
                   step = 1),
      sliderInput(inputId = "mom",
                   label = "Mom's height:",
                   value = 62, # default mother height
                   min = 48,
                   max = 78,
                   step = 1),
      radioButtons(inputId = "whichGender",
                   label = "Child's gender: ",
                   choices = c("Female"="female", "Male"="male"),
                   inline = TRUE)
    ),
    
    # Show text indicating the values entered
    mainPanel(
      #textOutput("parentsText"),
      textOutput("dadText"),
      textOutput("momText"),
      textOutput("prediction"),
      plotOutput("dotPlot", width="50%")
    )
    )
))