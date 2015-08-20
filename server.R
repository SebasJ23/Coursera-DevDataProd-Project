library(shiny)

simpleTotal <- function(principal, rate, times) {
    principal * (1 + (rate * times)/100)
}

compoundTotal <- function(principal, rate, times, compoundTime) {
    principal * ((1 + (rate / (100 * compoundTime))) ^ (times * compoundTime))
}

shinyServer(function(input, output) {
    # output only used once, therefore only needs to be named once:
    output$prediction <- renderPrint({
        input$calculate
        if (input$choice == "Simple interest") {
            isolate(simpleTotal(input$principal, input$rate, input$times) - input$principal)
        } else {
            isolate(compoundTotal(input$principal, input$rate, input$times, input$compoundTime) - input$principal)    
        }
        })
    output$total <- renderPrint({
        input$calculate
        if (input$choice == "Simple interest") {
            isolate(simpleTotal(input$principal, input$rate, input$times))
        } else {
            isolate(compoundTotal(input$principal, input$rate, input$times, input$compoundTime))
        }
        })
    output$currency2 <- renderText({input$currency})
    output$compoundTime <- renderText({input$compoundTime})
    output$timeMeasure2 <- renderText({paste0(strsplit(input$timeMeasure, "s"), ",")})
    # I need to name everything twice, otherwise it would not work: https://github.com/rstudio/shiny/issues/743
    # Output for simple interest text outcome:
    output$principalSimple <- renderText({input$principal})
    output$currencySimple <- renderText({input$currency})
    output$choiceSimple <- renderText({tolower(input$choice)})
    output$rateSimple <- renderText({paste0(input$rate, "%")})
    output$timesSimple <- renderText({input$times})
    output$timeMeasureSimple <- renderText({paste0(strsplit(input$timeMeasure, "s"), "(s)", ",")})
    # Output for compound interest text outcome:
    output$principalCompound <- renderText({input$principal})
    output$currencyCompound <- renderText({input$currency})
    output$choiceCompound <- renderText({tolower(input$choice)})
    output$rateCompound <- renderText({paste0(input$rate, "%")})
    output$timesCompound <- renderText({input$times})
    output$timeMeasureCompound <- renderText({paste0(strsplit(input$timeMeasure, "s"), "(s)", ",")})
})

