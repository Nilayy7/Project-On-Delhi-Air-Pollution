library(shiny)
library(shinythemes)
library(shinydashboard)
library(shinycssloaders)
library(forecast)
library(padr)
library(imputeTS)
library(readxl)
library(dplyr)
library(DT)
library(ggplot2)
library(shinyWidgets)




shinyUI ( navbarPage(
  theme = shinytheme("flatly"),
  strong("Delhi Pollution Forecasting "),
  
  tabPanel("Data Summary",
           sidebarLayout(
             sidebarPanel(
               h5(fileInput("file1", "Choose File with Date & pm2.5 Column",multiple = F,accept = c(".xlsx"),width = 500)),
               tags$hr(),
               
               sliderInput(inputId = "daysahead",label = "Days to Forecast Ahead",1,365,10)
                         ),
             mainPanel(
               fluidRow(
                 
                 h3(" Data Content"),
                 DT:: dataTableOutput("contents"),
                 tags$hr(),
                 
                 h3("Line Plot"),
                 plotOutput("navaluesplot")
               )
             )
           )),
  
  tabPanel("Pre-Processed Data",
           mainPanel(
             fluidRow(
              h2("Data Transformation"),
              p("In case of any missing value in data set then 'Moving Average' imputation technique would be used to treat NA values"),
               
             h3("Data Set"),
             DT:: dataTableOutput("Preview"),
             tags$hr(),
             
             h3("Line Plot"),
             plotOutput("Plot1")
                     )
                    )
             ),
  
  tabPanel("Neural Network Forecast",
           mainPanel(
             fluidRow(
               h3("Model Introduction"),
               p("Artificial neural networks are forecasting methods that are based on simple mathematical models of the brain. They allow complex nonlinear relationships between the response variable and its predictors."),
               
               h3(" Trend using NNETAR Model"),
               #plotOutput("forecastplot",click = "plot_click")%>% withSpinner(color="#0dc565"),
               addSpinner(shiny::plotOutput("forecastplot"),spin = "circle",color="#0dc565"),
               
               h3("Expected Values using NNETAR Model"),
               addSpinner(DT:: dataTableOutput("table1"),spin = "circle",color="#0dc565")
               
                    )
                   )   
          ) 
  
)
)
