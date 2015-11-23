library(shiny)
library(HistData)

library(dplyr)
library(ggplot2)

data(GaltonFamilies)
genders = c("female","male")
# use a reasonably simple linear model
lmfit <- lm(childHeight ~ father + mother + gender, data=GaltonFamilies)

shinyServer(function(input, output) {
  output$dadText <- renderText({
    paste("Given the dad's height:  ",
            round(input$dad, 1))
  })
  output$momText <- renderText({
    paste("And the mom's height:  ",
          round(input$mom, 1))
  })
#   output$parentsText <- renderText({
#     paste("Given the father's height:  ",
#           round(input$dad, 1),
#           "\n and mother's height:  ",
#           round(input$mom, 1))
#   })
  output$prediction <- renderText({
    df <- data.frame(father=input$dad,
                     mother=input$mom,
                     gender=factor(input$whichGender, levels=levels(GaltonFamilies$gender)))
    kidHeight <- predict(lmfit, newdata=df)
    sonOrDaughter <- ifelse(
      input$whichGender=="female",
      "daugther",
      "son"
    )
    paste0("Your ",
           sonOrDaughter,
           "'s predicted height would be approximately ",
           round(kidHeight, 1),
           " inches"
    )
  })

  output$dotPlot <- renderPlot({
    sonOrDaughter <- ifelse(
      input$whichGender=="female",
      "Daugther",
      "Son"
    )
    df <- data.frame(father=input$dad,
                     mother=input$mom,
                     gender=factor(input$whichGender, levels=levels(GaltonFamilies$gender)))
    kidHeight <- predict(lmfit, newdata=df)
    yvals <- c("Dad", "Mom", sonOrDaughter)
    df <- data.frame(
      x = factor(yvals, levels = yvals, ordered = TRUE),
      y = c(input$dad, input$mom, kidHeight)
    )
    ggplot(df, aes(x=x, y=y), color=factor(yvals)) +
      geom_point(shape=18, color="red") +
      xlab("") +
      ylab("Heights")
  })
})