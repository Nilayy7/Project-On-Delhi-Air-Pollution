library(shinydashboard)
library(shinycssloaders)
library(forecast)
library(padr)
library(imputeTS)
library(readxl)
library(dplyr)
library(DT)
library(ggplot2)
library(forecast)
library(ECharts2Shiny)


shinyServer<- function(input,output,session){
  
  data <- reactive({ 
    req(input$file1) ## ?req #  require that the input is available
    inFile <- input$file1 
    file.rename(inFile$datapath,paste(inFile$datapath, ".xlsx", sep=""))
    df <- read_excel(paste(inFile$datapath, ".xlsx", sep=""))
    df$pm25 <- as.numeric(df$pm25)
    return(df)
  })
  
  ##############
  
  output$contents <- DT:: renderDataTable({
    data()
  })
  
  output$navaluesplot<- renderPlot({
    if(is.null(data())!=T){
      ggplot(data = data(),aes(x= date,y= pm25)) + 
        geom_line(colour='blue') +
        theme(panel.background = element_blank())+
        ylim(0,750)+
        ggtitle("Missing Values")
      
    }
  })
  
  re <- reactive({
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    file.rename(inFile$datapath,paste(inFile$datapath, ".xlsx", sep=""))
    delhi <- read_excel(paste(inFile$datapath, ".xlsx", sep=""))
    delhi$pm25 <- as.numeric(delhi$pm25)
    delhi<- pad(as.data.frame(delhi,interval = NULL, start_val = NULL, end_val =NULL))
    delhi$pm_ma<-na_seasplit(delhi$pm25,algorithm = "ma",find_frequency = T)
    delhi_fill_1 <- delhi[,c(1,3)]
    colnames(delhi_fill_1) <- c("Date","PM25")
    delhi_fill_1$PM25 <- msts( delhi_fill_1$PM25,seasonal.periods = c(24, 24*7))
    delhi_fill_1
  })
  
  output$Preview <- DT:: renderDataTable({
    delhi_fill_1<- re()
  })

  
  output$Plot1<-  renderPlot({
    
    if(is.null(re())!=T){
      ### With TIME SERIES MOVING AVERAGE
      ggplot(data = re(),aes(x= Date,y= PM25)) + 
        geom_line(colour='red') +
        geom_line(colour="Blue",data = data(),aes(x= date,y= pm25))+
        theme(panel.background = element_blank())+
        ylim(0,750)+
        ggtitle("MOVING AVERAGE Values")
      
    }
    
  })
  
  output$forecastplot<- renderPlot({
    delhi_fill_1<- re()
    fit<- nnetar(delhi_fill_1$PM25)
    plot(forecast(fit,h = input$daysahead*24),xlab = "Date",ylab = "PM25")
  })
  
  output$table1<- DT:: renderDataTable({
    delhi_fill_1<- re()
    fit<- nnetar(delhi_fill_1$PM25)
    pred <- as.data.frame (forecast(fit,h=input$daysahead*24))
    pred$Date <- seq(from = as.POSIXct("2018-04-20 01:00",tz="UTC"), length.out = input$daysahead*24, by = "hour")
    pred$'Point Forecast' <- round(pred$'Point Forecast')
    pred <- pred[c(2,1)]
    rownames(pred) <- 1:nrow(pred)
    pred
  })
 
}

 