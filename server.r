recipe <- function(pH, mM) {
        ratio<-10^(pH-6.865)
        a<- round(0.120*mM/(ratio+1), digits=2)
        b<- round(0.142*mM*ratio/(ratio+1), digits=2)
        result<-as.list(c(a,b))
}

shinyServer(
        function(input, output){
                output$a<- renderPrint({recipe(input$pH, input$mM)[[1]]})
                output$b<- renderPrint({recipe(input$pH, input$mM)[[2]]})
        }
)