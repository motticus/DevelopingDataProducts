library(shiny)
library(rCharts)
#shinyUI(
#  pageWithSidebar(
#    headerPanel("Diabetes Prediction"),
#    sidebarPanel(
#    numericInput('glucose', 'Glucose mg/dl', 90, min=50, max=200, step=5),
#   submitButton('Submit')
#    ),
#  mainPanel(
#  h3('Results of prediction'),
#  h4('You entered'),
#  verbatimTextOutput("inputValue"),
#  h4('Which resulted in a prediction of '),
##  verbatimTextOutput("prediction")
#  )
#)
#)
library(data.table)
dt <- read.csv("titanic.csv")

shinyUI(
  navbarPage("Titanic Survivor Log",
             tabPanel("Plot",
                      sidebarPanel(
                        sliderInput('ageSample', 'Choose Age Range', min=min(dt$Age), max=max(dt$Age, na.rm=TRUE),
                                    value=c(min(dt$Age), max(dt$Age, na.rm=TRUE)), step=0.1, round=0),
                        checkboxGroupInput("sexSample", "Sex:",
                                           c("Male" = "male",
                                             "Female" = "female"), choices = c("male", "female")),
                        checkboxGroupInput("classSample", "Class:",
                                           c("1st Class" = "1",
                                             "2nd Class" = "2",
                                             "Steerage" = "3"),choices = c("1", "2", "3")),
                        checkboxGroupInput("survivedSample", "Survived:",
                                           c("Survived" = "1",
                                             "Died" = "0"), choices = c("0", "1")),
                        sliderInput('siblingSample', 'Choose Sibling Range', min=min(dt$SibSp), max=max(dt$SibSp, na.rm=TRUE),
                                    value=c(min(dt$SibSp), max(dt$SibSp, na.rm=TRUE)), step=1, round=0),
                        sliderInput('parentSample', 'Choose Parent/Child Range', min=min(dt$Parch), max=max(dt$Parch, na.rm=TRUE),
                                    value=c(min(dt$Parch), max(dt$Parch, na.rm=TRUE)), step=1, round=0),  
                        sliderInput('fareSample', 'Choose Fare Range', min=min(dt$Fare), max=max(dt$Fare, na.rm=TRUE),
                                    value=c(min(dt$Fare), max(dt$Fare, na.rm=TRUE)), step=0.01, round=0)
                      ),
                      mainPanel(
                        tabsetPanel(
                          
                          # Data by state
                          tabPanel(p(icon("line-chart"), "Survival"),
                                   column(7,
                                   plotOutput("survivalValue"), 
                                   h4("Total"),
                                   textOutput("survival"),
                                   h4("Total Male"),
                                   textOutput("survivalmale"),
                                   h4("Total Female"),
                                   textOutput("survivalfemale"),
                                   h4("Total First Class"),
                                   textOutput("survival1"),
                                   h4("Total Second Class"),
                                   textOutput("survival2"),
                                   h4("Total Third Class"),
                                   textOutput("survival3"),
                                   h4("Mean Age"),
                                   textOutput("meansurvivalage"),
                                   h4("Mean Fare"),
                                   textOutput("meansurvivalfare")
                                   )
                                   
                          ),                     
                          tabPanel(p(icon("line-chart"), "Not Survival"),
                                   column(7,
                                          plotOutput("notSurvivalValue"),
                                          h4("Total"),
                                          textOutput("notsurvival"),
                                          h4("Total Male"),
                                          textOutput("notsurvivalmale"),
                                          h4("Total Female"),
                                          textOutput("notsurvivalfemale"),
                                          h4("Total First Class"),
                                          textOutput("notsurvival1"),
                                          h4("Total Second Class"),
                                          textOutput("notsurvival2"),
                                          h4("Total Third Class"),
                                          textOutput("notsurvival3"),
                                          h4("Mean Age"),
                                          textOutput("meannotsurvivalage"),
                                          h4("Mean Fare"),
                                          textOutput("meannotsurvivalfare")
                                   )
                                   
                          ),                                
                          # Data 
                          tabPanel(p(icon("table"), "Data"),
                                   dataTableOutput(outputId="table"),
                                   downloadButton('downloadData', 'Download')
                          )
                        )
                      )
                      
             ),
             
             tabPanel("About",
                      mainPanel(
                        includeMarkdown("include.md")
                      )
             )
  )
)