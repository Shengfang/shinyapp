---
title       : Phosphate buffer calculator
author      : Shengfang
framework   : io2012      # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## How the calculator works

- A phosphate buffer solution is a handy buffer around for chemistry and biological applications. A phosphate buffer resists changes in pH when acid or alkali is added to it and maintain a constant pH ranging between 5.8 ~ 8.0.
- Phosphate buffer can be prepared for desired pH by dissolving right amount of monosodium phosphate and its conjugate base, disodium phosphate, into water.
- The calculator take two input numbers: **Buffer pH** and **Buffer Strength** (10-100). Ater hit the **Calculate!** button, it will run calculation using Henderson-Hasselbach equation (pH = pKa + log ([Base]/[Acid]) and return the result. The result tells how many grams of monosodium phosphate (Acid) and disodium phosphate (Base) you need to prepare 1 liter of phosphate buffer solution. 

---

## How to use

- Type desired **buffer pH** into the first cell and the intended **buffer strength** (in unit of milimolar) in the second cell. 
- Press the **Calculate!** button.
- The receipe will be displayed.

---
### Code: ui.r

```r
library(shiny)
```

```
## Warning: package 'shiny' was built under R version 3.1.2
```

```r
shinyUI(
        pageWithSidebar(
                headerPanel("Phosphate buffer calculator"),
                sidebarPanel(
                        numericInput("pH", "Buffer pH", 7.1, min=5.8, max=8.0, step=0.1),
                        numericInput("mM", "Buffer strength (mM)", 10, min=10, max=1000, 
                                     step=10),
                        submitButton("Calculate!")
                        ),
                mainPanel(h3("Recipe for 1 liter of buffer solution:"),
                          h4("Monosodium phosphate (gram):"),
                          verbatimTextOutput("a"),h4("Disodium phosphate (gram):"),
                          verbatimTextOutput("b"))
                ))
```

<!--html_preserve--><div class="container-fluid">
<div class="row-fluid">
<div class="span12" style="padding: 10px 0px;">
<h1>Phosphate buffer calculator</h1>
</div>
</div>
<div class="row-fluid">
<div class="span4">
<form class="well">
<label for="pH">Buffer pH</label>
<input id="pH" type="number" value="7.1" min="5.8" max="8" step="0.1"/>
<label for="mM">Buffer strength (mM)</label>
<input id="mM" type="number" value="10" min="10" max="1000" step="10"/>
<div>
<button type="submit" class="btn btn-primary">Calculate!</button>
</div>
</form>
</div>
<div class="span8">
<h3>Recipe for 1 liter of buffer solution:</h3>
<h4>Monosodium phosphate (gram):</h4>
<pre id="a" class="shiny-text-output"></pre>
<h4>Disodium phosphate (gram):</h4>
<pre id="b" class="shiny-text-output"></pre>
</div>
</div>
</div><!--/html_preserve-->

---

### Code: function

```r
recipe <- function(pH, mM) {
ratio<-10^(pH-6.9)
a<- round(0.120*mM/(ratio+1), digits=2)
b<- round(0.142*mM*ratio/(ratio+1), digits=2)
result<-as.list(c(a,b))
}
```

### Code: server.r

```r
shinyServer(
        function(input, output){
                output$a<- rederPrint({recipe(input$pH, input$mM)[[1]]})
                output$b<- rederPrint({recipe(input$pH, input$mM)[[2]]})
        }
        )
```

### Run the app: runApp()





