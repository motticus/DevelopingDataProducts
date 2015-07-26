# server.R The backend portion of Shiny

#load libraries
library(shiny)
library(data.table)

#load dataset
dt <- read.csv("titanic.csv")

#temporary dataset
dataset <- dt

#Shiny server load. 
shinyServer(
  function(input, output, session) {
    
    #The reactive step.  This step is in one reactive function because all of them apply to one action. 
    #This narrows the scope of the dataset. 
    dataset <- reactive({
      dt <- subset(dt, dt$Age > input$ageSample[1])
      dt <- subset(dt, dt$Age < input$ageSample[2])
      dt <- subset(dt, dt$SibSp > input$siblingSample[1])
      dt <- subset(dt, dt$SibSp < input$siblingSample[2])
      dt <- subset(dt, dt$Parch > input$parentSample[1])
      dt <- subset(dt, dt$Parch < input$parentSample[2])
      dt <- subset(dt, dt$Fare > input$fareSample[1])
      dt <- subset(dt, dt$Fare < input$fareSample[2])
      dt <- dt[(dt$Sex %in% input$sexSample),]
      dt <- dt[(dt$Pclass %in% input$classSample),]
      dt <- dt[(dt$Survived %in% input$survivedSample),]
    })
    
    #load datatable 
    output$table <- renderDataTable(dt)
    
    #all of the various items to be rendered as a plot or text value. 
    output$survivalValue <- renderPlot({
      survived <- subset(dataset(), Survived==1)
      hist(survived$Age, xlab='age', col='lightblue', main="Survived")
    })
    output$notSurvivalValue <- renderPlot({
      notsurvived <- subset(dataset(), Survived==0)
      hist(notsurvived$Age, xlab='age', col='lightblue', main="Did not Survive")
    })
    output$meansurvivalage <- renderText({
      survived <- subset(dataset(), Survived==1)
      mean(survived$Age)
    })
    output$meannotsurvivalage <- renderText({
      notsurvived <- subset(dataset(), Survived==0)
      mean(notsurvived$Age)
    })
    output$survivalmale <- renderText({
      survived <- subset(dataset(), Survived==1)
      survived <- subset(survived, survived$Sex=="male")
      nrow(survived)
    })
    output$survivalfemale <- renderText({
      survived <- subset(dataset(), Survived==1)
      survived <- subset(survived, survived$Sex=="female")
      nrow(survived)
    })
    output$notsurvivalmale <- renderText({
      notsurvived <- subset(dataset(), Survived==0)
      notsurvived <- subset(notsurvived, notsurvived$Sex=="male")
      nrow(notsurvived)
    })
    output$notsurvivalfemale <- renderText({
      notsurvived <- subset(dataset(), Survived==0)
      notsurvived <- subset(notsurvived, notsurvived$Sex=="female")
      nrow(notsurvived)
    })
    output$survival1 <- renderText({
      survived <- subset(dataset(), Survived==1)
      survived <- subset(survived, survived$Pclass==1)
      nrow(survived)
    })
    output$survival2 <- renderText({
      survived <- subset(dataset(), Survived==1)
      survived <- subset(survived, survived$Pclass==2)
      nrow(survived)
    })
    output$survival3 <- renderText({
      survived <- subset(dataset(), Survived==1)
      survived <- subset(survived, survived$Pclass==3)
      nrow(survived)
    })
    output$notsurvival1 <- renderText({
      notsurvived <- subset(dataset(), Survived==0)
      notsurvived <- subset(notsurvived, notsurvived$Pclass==1)
      nrow(notsurvived)
    })
    output$notsurvival2 <- renderText({
      notsurvived <- subset(dataset(), Survived==0)
      notsurvived <- subset(notsurvived, notsurvived$Pclass==2)
      nrow(notsurvived)
    })
    output$notsurvival3 <- renderText({
      notsurvived <- subset(dataset(), Survived==0)
      notsurvived <- subset(notsurvived, notsurvived$Pclass==3)
      nrow(notsurvived)
    })
    output$survival <- renderText({
      survived <- subset(dataset(), Survived==1)
      nrow(survived)
    })
    output$notsurvival <- renderText({
      notsurvived <- subset(dataset(), Survived==0)
      nrow(notsurvived)
    })
    output$meansurvivalfare <- renderText({
      survived <- subset(dataset(), Survived==1)
      round(mean(survived$Fare), digits=2)
    })
    output$meannotsurvivalfare <- renderText({
      notsurvived <- subset(dataset(), Survived==0)
      round(mean(notsurvived$Fare), digits=2)
    })
  })