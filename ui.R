library(shiny)

shinyUI(navbarPage("Interest Calculator", tabPanel("App",
    pageWithSidebar(
    headerPanel(h2("Interest Calculator")), # App tittle
    sidebarPanel(h3("Input values"), # Input panel tittle
                 p("This application calculates the interest gained on an investment or savings. It can calculate both simple and compound interests."), # App description
                 numericInput("principal", "Initial amount of money", 0, min = 0),
                 textInput("currency", "Currency", "USD"),
                 numericInput("rate", "Interest rate (%)", 0, min = 0, max = 200),
                 numericInput("times", "Time", 0, min = 0),
                 selectInput("timeMeasure", "Time measured in:", c("days", "months", "years"), selected = "years"),
                 radioButtons("choice", "Type of interest", choices = c("Simple interest", "Compound interest")),
                 conditionalPanel(
                     condition = "input.choice == 'Simple interest'"#,
#                     selectInput("compoundTime", "Number of times compounded per day/month/year", choices = "NA")
                 ),
                 conditionalPanel(
                     condition = "input.choice == 'Compound interest'",
                     numericInput("compoundTime", "Number of times compounded per day/month/year", 0, min = 0, step = 1)
                 ),
                 actionButton("calculate","Calculate")
                 ),
    mainPanel(h3("Results"), # Output panel tittle
              conditionalPanel(
                  condition = "input.choice == 'Simple interest'",
                  p("For an initial investment of",
                    textOutput("principalSimple", inline = TRUE),
                    textOutput("currencySimple", inline = TRUE),
                    "with a",
                    textOutput("choiceSimple", inline = TRUE),
                    "rate of",
                    textOutput("rateSimple", inline = TRUE),
                    "for",
                    textOutput("timesSimple", inline = TRUE),
                    textOutput("timeMeasureSimple", inline = TRUE),
                    "the interest gained is:")
                ),
              conditionalPanel(
                  condition = "input.choice == 'Compound interest'",
                  p("For an initial investment of",
                  textOutput("principalCompound", inline = TRUE),
                  textOutput("currencyCompound", inline = TRUE),
                  "with a",
                  textOutput("choiceCompound", inline = TRUE),
                  "rate of",
                  textOutput("rateCompound", inline = TRUE),
                  "for",
                  textOutput("timesCompound", inline = TRUE),
                  textOutput("timeMeasureCompound", inline = TRUE),
                  "and compounded",
                  textOutput("compoundTime", inline = TRUE),
                  "times each",
                   textOutput("timeMeasure2", inline = TRUE),
                  "the interest gained is:")
               ),
              verbatimTextOutput("prediction"),
              p("Which together with the initial investment amounts to a total",
                textOutput("currency2", inline = TRUE),
                "of:"),
              verbatimTextOutput("total")
)
)), tabPanel("Documentation",
             mainPanel(h2("Documentation"),
                       p("This application calculates the interest gained on an investment or savings. It can calculate both simple and compound interests."),
                       h3("How to use it"),
                       p("Use the left panel to introduce all the needed variables to calculate the interest gained. For a simple interest (default mode), these variables are:"),
                       p("1. Initial amount of money invested"), p("2. Interest rate in percentage"),
                       p("3. Time the investment is gaining interest"),
                       br(),
                       p("You can also calculate compound interest by choosing this option under the 'Type of interest' section.
                         In this case, please also specify the number of times the interest is compounded per unit of time (i.e. times compounded per year, month or day)"),
                       br(),
                       p("The application also allows to customize two other features of an investment:"),
                       p("1. The currency in which the investment is made (e.g. USD, EUR, COP)"),
                       p("2. The unit of time for the investment. Normally, this unit will be years."),
                       br(),
                       p("Finally, when you have successfully completed all the information, hit 'Calculate' at the bottom of the page and the results will appear on the 'Results' section"),
                       h3("Results"),
                       p("The results presented in the 'Results' section are as follows:"),
                       p("1. The interest gained over the initial investment"),
                       p("2. The total amount of money (initial investment + interest gained)")
                       )))
)

