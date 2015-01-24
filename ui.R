library(shiny)
library(UsingR)
library(ggplot2)
library(grid)
library(reshape2)
library(plyr)
library(scales)

shinyUI(navbarPage("Spend it? or Save it?",
            tabPanel("Spending?",
                  sidebarLayout(
                        
                        sidebarPanel(
                              sliderInput('co', 'Coffee per week ($)',value = 15, min = 0, max = 63, step = 3),
                              sliderInput('sw', 'Snacks per week ($)',value = 15, min = 0, max = 63, step = 3,),
                              sliderInput('dr', 'Shopping per week ($)', value= 40, min = 0, max = 700, step = 10),
                              sliderInput('ta', 'Dining out per week ($)',value = 140, min = 0, max = 700, step = 10),
                              numericInput('ot', 'Other spendings per week ($)', 0, min = 0, max = 10000, step = 1)

                        ),
                        mainPanel(

                                             h3("Your weekly spending is", span(textOutput("caption"), style = "color:red"),"Affordable? Think again in years."),
                                             plotOutput("myplot3", height = 400, width = 400)
   
                        )
                  )
            
            ),

            tabPanel("Saving!",       

                  sidebarPanel(
  
                        sliderInput('ya', 'Years of accumulation',value = 30, min = 1, max = 50, step = 1,)


                  ),
                  mainPanel(

                              h3("Don't spend it. Piggy bank it. This is how much you can save over the years."),
                              plotOutput("myplot2")

                  )
            ),
            tabPanel("How to use this App",       
                     
#                      sidebarPanel(
#                            
#                            sliderInput('ya', 'Years of accumulation',value = 20, min = 1, max = 50, step = 1,)
#                            
#                            
#                      ),
                     mainPanel(
                           
                           h2("Calcurate how much you spend on regular basis per week."),
                           h3("1. Click 'Spending?' bar at the top."),
                           h3("2. Select your spending using sliding bars on the left. "),
                           h3("3. You can add your other weekly spendings by putting number in the 'Other spending per week ($)' box. "),
                           h3("4. Your total weekly spending will be diplayed on the right side in red."),
                           br(),
                           h2("Check out how much you can save if you stop spending."),
                           h3("1. Click 'Saving!' bar at the top."),
                           h3("2. Select 'years of accumulation'. The chart will show the total savings over the years.")
                           
                           
                     )
            )
))



# runApp()