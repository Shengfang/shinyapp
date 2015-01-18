library(shiny)
shinyUI(
        pageWithSidebar(
                headerPanel("Phosphate buffer calculator"),
                sidebarPanel(
                        h4("How to use"), 
                        p("- Type desired buffer pH into the first cell and buffer strength in the second."),                                                                               
                        p("- Press the Calculate! button."),
                        p("- The receipe will be displayed on the right."),
                        numericInput("pH", h4("Buffer pH"), 7.1, min=5.8, max=8.0, step=0.1),
                        numericInput("mM", h4("Buffer strength (mM)"), 10, min=10, max=1000, step=10),
                        submitButton("Calculate!")
                ),
                mainPanel(
                        h3("Recipe for 1 liter of buffer solution:"),
                        h4("Monosodium phosphate (gram):"),
                        verbatimTextOutput("a"),
                        h4("Disodium phosphate (gram):"),
                        verbatimTextOutput("b")
        )
)
)