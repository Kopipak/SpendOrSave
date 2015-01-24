library(shiny)
library(UsingR)
library(ggplot2)
library(grid)
library(reshape2)
library(plyr)
library(scales)


shinyServer(
      function(input, output) {

      formulaText <- reactive({
            co <- input$co
            sw <- input$sw
            dr <- input$dr
            ta <- input$ta
            ot <- input$ot
            wk <- sum(co*1,sw*1,dr*1,ta*1, ot)  
            paste("$", wk)
      })
      
      # Return the formula text for printing as a caption
      output$caption <- renderText({
            formulaText()
      })

      output$myplot2 <- renderPlot({
            co <- input$co
            sw <- input$sw
            dr <- input$dr
            ta <- input$ta
            ot <- input$ot 
            ya <- input$ya    # simulating years
            years <- 1:ya

            wk <- sum(co*1,sw*1,dr*1,ta*1, ot)     ## 52week for a year. average per month(x 4.345week)
            spending <- wk *52
            spendday <- spending/365
            
            mo <- data.frame(years,0)
            names(mo) <- c("Years","Piggy banking")
            tl <- 0
            for(n in 1:ya){
                  tl <- tl + spending
                  mo[n,2] <- tl

            }
         
            data <- melt(mo, id=c("Years")) 
            pig <- ggplot(data, aes(x=Years, y=value, fill=variable)) + geom_bar(stat="identity", position="dodge") + labs(x= "Years") + 
                  theme(text = element_text(size=20)) + 
                  theme(legend.title=element_blank()) + theme(legend.justification=c(0,1), legend.position=c(0,1))+
                  theme(legend.background = element_rect(fill="gray90", size=.5, linetype="dotted"))+ scale_y_continuous(labels = dollar) +
                  theme(axis.title.y = element_blank()) + scale_fill_manual(values=c("#56B4E9"))
            print(pig)
      })
      
      output$myplot3 <- renderPlot({
            
            co <- input$co
            sw <- input$sw
            dr <- input$dr
            ta <- input$ta
            ot <- input$ot
            
            list<- factor(c("Coffee" ,"Snack","Shopping", "Dining","Other"), levels = c("Coffee" ,"Snack","Shopping", "Dining","Other"))
            data <- data.frame(list)
            data$Total <- c(co*1,sw*1,dr*1,ta*1, ot)
            data$week <- 1

            spn<- ggplot(data, aes(x=week, y=Total, fill=list, order = desc(list)))+ geom_bar(stat="identity") + theme(legend.title=element_blank())+
                  theme(axis.title.y=element_text(colour="grey",size=25)) + theme(axis.text.y = element_text(size=rel(1.8))) +
                  theme(legend.text = element_text(colour="black", size = 25)) + theme(axis.title.x = element_blank()) + scale_x_discrete(breaks=NULL)+ theme(panel.background = element_blank())+
                  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + scale_y_continuous(labels = dollar) +
                  theme(axis.title.y = element_blank()) + scale_fill_discrete(breaks=c("Coffee" ,"Snack","Shopping", "Dining","Other"))
            print(spn)

      })

      }
)